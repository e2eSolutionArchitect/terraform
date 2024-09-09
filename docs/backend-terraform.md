
# Terraform backend for Azure

```
terraform{
  required_version = "~> 1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }
  }
  backend "azurerm" {
  container_name = "tfstatefiles"
  key = ""
  resource_group_name = ""
  snapshot = true
  storage_account_name = "<stg acc name>"
  subscription_id = "<sub id>"
  tenant_id = "<tenant id>"
  }
}
```


# Terraform backend for AWS

```
terraform {
  required_version = "~> 1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }
  }

  # TF State Management
  # Variables not allowed in backend block. 
  backend "s3" {
    bucket         = "tf-states"
    key            = "enter/path/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-locks"
    encrypt        = true
    profile        = "profile"
  }
}

# provider block

provider "aws" {
  profile = "profile"
  region  = var.aws_region
}
```
