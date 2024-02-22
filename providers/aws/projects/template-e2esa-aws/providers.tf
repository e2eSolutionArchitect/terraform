terraform {
  required_version = "~> 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.37.0"
    }
  }
}

# provider block

provider "aws" {
  profile = "default"
  region  = var.aws_region
}