terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.39.1"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.61.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  #It's also possible to configure Terraform to use a specific Subscription - for example:
  #subscription_id = "00000000-0000-0000-0000-000000000000"
}