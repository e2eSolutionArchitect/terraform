terraform {
  required_version = "~> 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37.0"
    }
  }

  # TF State Management

  backend "s3" {
    bucket         = "e2esa-tf-states"
    key            = "spm/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = var.backend_dynamodb_table
    encrypt        = true
    profile        = "default"
  }

}

# provider block

provider "aws" {
  profile = "default"
  region  = var.aws_region
}