output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}

output "latest_version" {
  value = data.azurerm_kubernetes_service_versions.selected.latest_version
}

output "grafana_url" {
  value = azurerm_dashboard_grafana.dashboard.endpoint
}