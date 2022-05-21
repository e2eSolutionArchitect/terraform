terraform {
  required_version = "~> 1.1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
  # backend "s3" {}
  # backend "s3" {
  #   bucket         = var.backend_s3_bucket
  #   key            = "${var.project}/terraform.tfstate"
  #   region         = var.aws_region
  #   dynamodb_table = var.backend_dynamodb_table
  #   encrypt        = true
  #   profile        = var.profile
  # }
}

# provider block

provider "aws" {
  profile = var.profile
  region  = var.aws_region
}
