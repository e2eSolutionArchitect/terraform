
# Error
Error encountered while provisioning Azure Managed Grafana using Terraform

│ Error: creating Grafana (Subscription: "#####"
│ Resource Group Name: "rg-us-east-aks"
│ Grafana Name: "grafasa-dash"): performing GrafanaCreate: Put "https://management.azure.com/subscriptions/#####/resourceGroups/rg-us-east-aks/providers/Microsoft.Dashboard/grafana/grafasa-dash?api-version=2023-09-01": The Resource Provider was not registered
│
│ Resource Providers (APIs) in Azure need to be registered before they can be used - however the Resource
│ Provider was not registered, and calling the API returned the following error:
│
│ The subscription is not registered to use namespace 'Microsoft.Dashboard'. See https://aka.ms/rps-not-found for how to register subscriptions. >
│
│ The Azure Provider by default will automatically register certain Resource Providers at launch-time,
│ whilst it's possible to opt-out of this (which you may have done)
│
│ Please ensure that this Resource Provider is properly registered, you can do this using the Azure CLI
│ for example to register the Resource Provider "Some.ResourceProvider" is registered run:
│
│ > az provider register --namespace "Some.ResourceProvider"
│
│ Resource Providers can take a while to register, you can check the status by running:
│
│ > az provider show --namespace "Some.ResourceProvider" --query "registrationState"
│
│ Once this outputs "Registered" the Resource Provider is available for use and you can re-run Terraform.


# Reference
Please check [here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/error-register-resource-provider?tabs=azure-cli) for MS documentation

# Solution:
Add following to skip registration

```
# Taken namespace from the error log "The subscription is not registered to use namespace 'Microsoft.Dashboard'" and run below command in CLI. It will register the dashboard in your subscription.
az provider register --namespace "Microsoft.Dashboard"

az provider show -n "Microsoft.Dashboard"
```
