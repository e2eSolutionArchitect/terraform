## Run below TF code to provision azurerm_storage_account. which will be used as state file storage.  Please [refer here](https://developer.hashicorp.com/terraform/language/settings/backends/azurerm) for more details.
[Azure documentation](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)

```
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.44.1"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstate" {
  name     = "rg-terraform-states"
  location = "West Europe"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "storage-tfstate-${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "demo"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "stg-cont-tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

```

## Now setup TF Backend  for Azure as below.

```
terraform {
  backend "azurerm" {
    resource_group_name  = "<resource-group-name>"  # rg-terraform-states
    storage_account_name = "<storage-tfstate-randomno>"
    container_name       = "<storage-container-name>" # stg-cont-tfstate
    key                  = "infra.tfstate"
  }
}
```
