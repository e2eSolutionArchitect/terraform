
# ------------------------------------------
# Azure Resource Group
# ------------------------------------------
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


# ------------------------------------------
# Azure Kubernetes Services Cluster
# ------------------------------------------

data "azurerm_kubernetes_service_versions" "selected" {
  location = azurerm_resource_group.rg.location
}

resource "azuread_group" "aks_administrators" {
  display_name     = "${azurerm_resource_group.rg.name}-cluster-administrators"
  security_enabled = true
  description      = "Azure AKS Kubernetes administrators for the ${azurerm_resource_group.rg.name}-cluster."
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                              = var.ask_cluster_name
  location                          = azurerm_resource_group.rg.location
  resource_group_name               = azurerm_resource_group.rg.name
  dns_prefix                        = var.dns_prefix
  kubernetes_version                = data.azurerm_kubernetes_service_versions.selected.latest_version #var.kubversion
  role_based_access_control_enabled = true

  default_node_pool {
    name                 = "default"
    node_count           = 1
    vm_size              = var.vm_size
    orchestrator_version = data.azurerm_kubernetes_service_versions.selected.latest_version #var.kubversion
  }

  # azure will assign the id automatically
  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id
  }

  # RBAC and Azure AD Integration Block
  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = [azuread_group.aks_administrators.id]
  }

  # network_profile {
  #   network_plugin = "azure"
  #   load_balancer_sku = "Standard"
  #   dns_service_ip     = var.aks_dns_service_ip
  #   docker_bridge_cidr = var.aks_docker_bridge_cidr
  #   service_cidr       = var.aks_service_cidr
  # }

  tags = merge(
    { "resourcename" = "${var.ask_cluster_name}" }, local.tags
  )

  lifecycle {
    ignore_changes  = [default_node_pool.0.node_count]
    prevent_destroy = false
  }
}


resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 2

  tags = merge(
    { "resourcename" = "nodepool" }, local.tags
  )
}


# ------------------------------------------
# Azure Container Registry
# ------------------------------------------

resource "azurerm_container_registry" "acr" {
  name                = var.az_container_registry_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
  tags = merge(
    { "resourcename" = "${var.az_container_registry_name}" }, local.tags
  )
}

resource "azurerm_role_assignment" "kubweb_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
}

# ------------------------------------------
# Azure Log Analytics Workspace
# ------------------------------------------

resource "random_id" "log_ws_suffix" {
  byte_length = 8
}


resource "azurerm_log_analytics_workspace" "log" {
  name                = "${var.analytics_workspace_name}-${random_id.log_ws_suffix.dec}" #var.analytics_workspace_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = merge(
    { "resourcename" = "${var.analytics_workspace_name}" }, local.tags
  )
}

resource "azurerm_log_analytics_solution" "log" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.log.location
  resource_group_name   = azurerm_resource_group.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.log.id
  workspace_name        = azurerm_log_analytics_workspace.log.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }

  tags = merge(
    { "resourcename" = "ContainerInsights" }, local.tags
  )

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "control_plane" {
  name                       = "AKS Control Plane Logging"
  target_resource_id         = azurerm_kubernetes_cluster.aks_cluster.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id

  enabled_log {
    category = "cloud-controller-manager"
  }

  enabled_log {
    category = "cluster-autoscaler"
  }

  enabled_log {
    category = "csi-azuredisk-controller"
  }

  enabled_log {
    category = "csi-azurefile-controller"
  }

  enabled_log {
    category = "csi-snapshot-controller"
  }

  enabled_log {
    category = "kube-apiserver"
  }

  enabled_log {
    category = "kube-controller-manager"
  }

  enabled_log {
    category = "kube-scheduler"
  }

  metric {
    category = "AllMetrics"
    enabled  = false
  }
}


# ------------------------------------------
# Enable Managed Grafana Dashboard
# ------------------------------------------

resource "azurerm_monitor_workspace" "monitor" {
  name                          = var.az_monitor_workspace_name
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  public_network_access_enabled = true
  tags = merge(
    { "resourcename" = "${var.analytics_workspace_name}" }, local.tags
  )
}


resource "azurerm_dashboard_grafana" "dashboard" {
  name                              = var.grafana_dashboard_name
  resource_group_name               = azurerm_resource_group.rg.name
  location                          = azurerm_resource_group.rg.location
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = false
  public_network_access_enabled     = true

  identity {
    type = "SystemAssigned"
  }
  azure_monitor_workspace_integrations {
    resource_id = azurerm_monitor_workspace.monitor.id
  }

  tags = merge(
    { "resourcename" = "${var.grafana_dashboard_name}" }, local.tags
  )
}

# Add required role assignment over resource group containing the Azure Monitor Workspace
resource "azurerm_role_assignment" "grafana" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.dashboard.identity[0].principal_id
}


# Add role assignment to Grafana so an admin user can log in
resource "azurerm_role_assignment" "grafana-admin" {
  scope                = azurerm_dashboard_grafana.dashboard.id
  role_definition_name = "Grafana Admin"
  principal_id         = [azuread_group.aks_administrators.id][0]
}

# resource "azurerm_dashboard_grafana_managed_private_endpoint" "endpoint" {
#   name                  = "${var.grafana_dashboard_name}-endpoint"
#   dashboard_grafana_id  = azurerm_dashboard_grafana.dashboard.id
#   target_resource_id    = azurerm_monitor_workspace.monitor.id
#   subresource_name      = "prometheusMetrics"
# }



resource "azurerm_monitor_data_collection_endpoint" "dce" {
  name                = "MSProm-${azurerm_monitor_workspace.monitor.location}-${azurerm_kubernetes_cluster.aks_cluster.name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_monitor_workspace.monitor.location
  kind                = "Linux"
}


resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                        = "MSProm-${azurerm_monitor_workspace.monitor.location}-${azurerm_kubernetes_cluster.aks_cluster.name}"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_monitor_workspace.monitor.location
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.dce.id
  kind                        = "Linux"
  destinations {
    monitor_account {
      monitor_account_id = azurerm_monitor_workspace.monitor.id
      name               = "MonitoringAccount1"
    }
  }
  data_flow {
    streams      = ["Microsoft-PrometheusMetrics"]
    destinations = ["MonitoringAccount1"]
  }
  data_sources {
    prometheus_forwarder {
      streams = ["Microsoft-PrometheusMetrics"]
      name    = "PrometheusDataSource"
    }
  }
  description = "DCR for Azure Monitor Metrics Profile (Managed Prometheus)"
  depends_on = [
    azurerm_monitor_data_collection_endpoint.dce
  ]
}

resource "azurerm_monitor_data_collection_rule_association" "dcra" {
  name                    = "MSProm-${azurerm_monitor_workspace.monitor.location}-${azurerm_kubernetes_cluster.aks_cluster.name}"
  target_resource_id      = azurerm_kubernetes_cluster.aks_cluster.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
  description             = "Association of data collection rule. Deleting this association will break the data collection for this AKS Cluster."
  depends_on = [
    azurerm_monitor_data_collection_rule.dcr
  ]
}

resource "azapi_resource" "NodeRecordingRulesRuleGroup" {
  type      = "Microsoft.AlertsManagement/prometheusRuleGroups@2023-03-01"
  name      = "NodeRecordingRulesRuleGroup-${azurerm_kubernetes_cluster.aks_cluster.name}"
  location  = azurerm_monitor_workspace.monitor.location
  parent_id = azurerm_resource_group.rg.id
  body = jsonencode({
    "properties" : {
      "scopes" : [
        azurerm_monitor_workspace.monitor.id
      ],
      "clusterName" : azurerm_kubernetes_cluster.aks_cluster.name,
      "interval" : "PT1M",
      "rules" : [
        {
          "record" : "instance:node_num_cpu:sum",
          "expression" : "count without (cpu, mode) (  node_cpu_seconds_total{job=\"node\",mode=\"idle\"})"
        },
        {
          "record" : "instance:node_cpu_utilisation:rate5m",
          "expression" : "1 - avg without (cpu) (  sum without (mode) (rate(node_cpu_seconds_total{job=\"node\", mode=~\"idle|iowait|steal\"}[5m])))"
        },
        {
          "record" : "instance:node_load1_per_cpu:ratio",
          "expression" : "(  node_load1{job=\"node\"}/  instance:node_num_cpu:sum{job=\"node\"})"
        },
        {
          "record" : "instance:node_memory_utilisation:ratio",
          "expression" : "1 - (  (    node_memory_MemAvailable_bytes{job=\"node\"}    or    (      node_memory_Buffers_bytes{job=\"node\"}      +      node_memory_Cached_bytes{job=\"node\"}      +      node_memory_MemFree_bytes{job=\"node\"}      +      node_memory_Slab_bytes{job=\"node\"}    )  )/  node_memory_MemTotal_bytes{job=\"node\"})"
        },
        {
          "record" : "instance:node_vmstat_pgmajfault:rate5m",
          "expression" : "rate(node_vmstat_pgmajfault{job=\"node\"}[5m])"
        },
        {
          "record" : "instance_device:node_disk_io_time_seconds:rate5m",
          "expression" : "rate(node_disk_io_time_seconds_total{job=\"node\", device!=\"\"}[5m])"
        },
        {
          "record" : "instance_device:node_disk_io_time_weighted_seconds:rate5m",
          "expression" : "rate(node_disk_io_time_weighted_seconds_total{job=\"node\", device!=\"\"}[5m])"
        },
        {
          "record" : "instance:node_network_receive_bytes_excluding_lo:rate5m",
          "expression" : "sum without (device) (  rate(node_network_receive_bytes_total{job=\"node\", device!=\"lo\"}[5m]))"
        },
        {
          "record" : "instance:node_network_transmit_bytes_excluding_lo:rate5m",
          "expression" : "sum without (device) (  rate(node_network_transmit_bytes_total{job=\"node\", device!=\"lo\"}[5m]))"
        },
        {
          "record" : "instance:node_network_receive_drop_excluding_lo:rate5m",
          "expression" : "sum without (device) (  rate(node_network_receive_drop_total{job=\"node\", device!=\"lo\"}[5m]))"
        },
        {
          "record" : "instance:node_network_transmit_drop_excluding_lo:rate5m",
          "expression" : "sum without (device) (  rate(node_network_transmit_drop_total{job=\"node\", device!=\"lo\"}[5m]))"
        }
      ]
    }
  })

  schema_validation_enabled = false
  ignore_missing_property   = false
}


resource "azapi_resource" "KubernetesReccordingRulesRuleGroup" {
  type      = "Microsoft.AlertsManagement/prometheusRuleGroups@2023-03-01"
  name      = "KubernetesReccordingRulesRuleGroup-${azurerm_kubernetes_cluster.aks_cluster.name}"
  location  = azurerm_monitor_workspace.monitor.location
  parent_id = azurerm_resource_group.rg.id
  body = jsonencode({
    "properties" : {
      "scopes" : [
        azurerm_monitor_workspace.monitor.id
      ],
      "clusterName" : azurerm_kubernetes_cluster.aks_cluster.name,
      "interval" : "PT1M",
      "rules" : [
        {
          "record" : "node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate",
          "expression" : "sum by (cluster, namespace, pod, container) (  irate(container_cpu_usage_seconds_total{job=\"cadvisor\", image!=\"\"}[5m])) * on (cluster, namespace, pod) group_left(node) topk by (cluster, namespace, pod) (  1, max by(cluster, namespace, pod, node) (kube_pod_info{node!=\"\"}))"
        },
        {
          "record" : "node_namespace_pod_container:container_memory_working_set_bytes",
          "expression" : "container_memory_working_set_bytes{job=\"cadvisor\", image!=\"\"}* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,  max by(namespace, pod, node) (kube_pod_info{node!=\"\"}))"
        },
        {
          "record" : "node_namespace_pod_container:container_memory_rss",
          "expression" : "container_memory_rss{job=\"cadvisor\", image!=\"\"}* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,  max by(namespace, pod, node) (kube_pod_info{node!=\"\"}))"
        },
        {
          "record" : "node_namespace_pod_container:container_memory_cache",
          "expression" : "container_memory_cache{job=\"cadvisor\", image!=\"\"}* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,  max by(namespace, pod, node) (kube_pod_info{node!=\"\"}))"
        },
        {
          "record" : "node_namespace_pod_container:container_memory_swap",
          "expression" : "container_memory_swap{job=\"cadvisor\", image!=\"\"}* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,  max by(namespace, pod, node) (kube_pod_info{node!=\"\"}))"
        },
        {
          "record" : "cluster:namespace:pod_memory:active:kube_pod_container_resource_requests",
          "expression" : "kube_pod_container_resource_requests{resource=\"memory\",job=\"kube-state-metrics\"}  * on (namespace, pod, cluster)group_left() max by (namespace, pod, cluster) (  (kube_pod_status_phase{phase=~\"Pending|Running\"} == 1))"
        },
        {
          "record" : "namespace_memory:kube_pod_container_resource_requests:sum",
          "expression" : "sum by (namespace, cluster) (    sum by (namespace, pod, cluster) (        max by (namespace, pod, container, cluster) (          kube_pod_container_resource_requests{resource=\"memory\",job=\"kube-state-metrics\"}        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (          kube_pod_status_phase{phase=~\"Pending|Running\"} == 1        )    ))"
        },
        {
          "record" : "cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests",
          "expression" : "kube_pod_container_resource_requests{resource=\"cpu\",job=\"kube-state-metrics\"}  * on (namespace, pod, cluster)group_left() max by (namespace, pod, cluster) (  (kube_pod_status_phase{phase=~\"Pending|Running\"} == 1))"
        },
        {
          "record" : "namespace_cpu:kube_pod_container_resource_requests:sum",
          "expression" : "sum by (namespace, cluster) (    sum by (namespace, pod, cluster) (        max by (namespace, pod, container, cluster) (          kube_pod_container_resource_requests{resource=\"cpu\",job=\"kube-state-metrics\"}        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (          kube_pod_status_phase{phase=~\"Pending|Running\"} == 1        )    ))"
        },
        {
          "record" : "cluster:namespace:pod_memory:active:kube_pod_container_resource_limits",
          "expression" : "kube_pod_container_resource_limits{resource=\"memory\",job=\"kube-state-metrics\"}  * on (namespace, pod, cluster)group_left() max by (namespace, pod, cluster) (  (kube_pod_status_phase{phase=~\"Pending|Running\"} == 1))"
        },
        {
          "record" : "namespace_memory:kube_pod_container_resource_limits:sum",
          "expression" : "sum by (namespace, cluster) (    sum by (namespace, pod, cluster) (        max by (namespace, pod, container, cluster) (          kube_pod_container_resource_limits{resource=\"memory\",job=\"kube-state-metrics\"}        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (          kube_pod_status_phase{phase=~\"Pending|Running\"} == 1        )    ))"
        },
        {
          "record" : "cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits",
          "expression" : "kube_pod_container_resource_limits{resource=\"cpu\",job=\"kube-state-metrics\"}  * on (namespace, pod, cluster)group_left() max by (namespace, pod, cluster) ( (kube_pod_status_phase{phase=~\"Pending|Running\"} == 1) )"
        },
        {
          "record" : "namespace_cpu:kube_pod_container_resource_limits:sum",
          "expression" : "sum by (namespace, cluster) (    sum by (namespace, pod, cluster) (        max by (namespace, pod, container, cluster) (          kube_pod_container_resource_limits{resource=\"cpu\",job=\"kube-state-metrics\"}        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (          kube_pod_status_phase{phase=~\"Pending|Running\"} == 1        )    ))"
        },
        {
          "record" : "namespace_workload_pod:kube_pod_owner:relabel",
          "expression" : "max by (cluster, namespace, workload, pod) (  label_replace(    label_replace(      kube_pod_owner{job=\"kube-state-metrics\", owner_kind=\"ReplicaSet\"},      \"replicaset\", \"$1\", \"owner_name\", \"(.*)\"    ) * on(replicaset, namespace) group_left(owner_name) topk by(replicaset, namespace) (      1, max by (replicaset, namespace, owner_name) (        kube_replicaset_owner{job=\"kube-state-metrics\"}      )    ),    \"workload\", \"$1\", \"owner_name\", \"(.*)\"  ))",
          "labels" : {
            "workload_type" : "deployment"
          }
        },
        {
          "record" : "namespace_workload_pod:kube_pod_owner:relabel",
          "expression" : "max by (cluster, namespace, workload, pod) (  label_replace(    kube_pod_owner{job=\"kube-state-metrics\", owner_kind=\"DaemonSet\"},    \"workload\", \"$1\", \"owner_name\", \"(.*)\"  ))",
          "labels" : {
            "workload_type" : "daemonset"
          }
        },
        {
          "record" : "namespace_workload_pod:kube_pod_owner:relabel",
          "expression" : "max by (cluster, namespace, workload, pod) (  label_replace(    kube_pod_owner{job=\"kube-state-metrics\", owner_kind=\"StatefulSet\"},    \"workload\", \"$1\", \"owner_name\", \"(.*)\"  ))",
          "labels" : {
            "workload_type" : "statefulset"
          }
        },
        {
          "record" : "namespace_workload_pod:kube_pod_owner:relabel",
          "expression" : "max by (cluster, namespace, workload, pod) (  label_replace(    kube_pod_owner{job=\"kube-state-metrics\", owner_kind=\"Job\"},    \"workload\", \"$1\", \"owner_name\", \"(.*)\"  ))",
          "labels" : {
            "workload_type" : "job"
          }
        },
        {
          "record" : ":node_memory_MemAvailable_bytes:sum",
          "expression" : "sum(  node_memory_MemAvailable_bytes{job=\"node\"} or  (    node_memory_Buffers_bytes{job=\"node\"} +    node_memory_Cached_bytes{job=\"node\"} +    node_memory_MemFree_bytes{job=\"node\"} +    node_memory_Slab_bytes{job=\"node\"}  )) by (cluster)"
        },
        {
          "record" : "cluster:node_cpu:ratio_rate5m",
          "expression" : "sum(rate(node_cpu_seconds_total{job=\"node\",mode!=\"idle\",mode!=\"iowait\",mode!=\"steal\"}[5m])) by (cluster) /count(sum(node_cpu_seconds_total{job=\"node\"}) by (cluster, instance, cpu)) by (cluster)"
        }
      ]
    }
  })

  schema_validation_enabled = false
  ignore_missing_property   = false
}