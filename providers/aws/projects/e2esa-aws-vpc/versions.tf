terraform {
  required_version = "~> 1.1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }

  backend "s3" {
    bucket         = "e2esa-tf-states"
    key            = "vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "e2esa-tf-locks"
    encrypt        = true
    profile        = "default"
  }
}

# provider block

provider "aws" {
  profile = "default"
  region  = var.aws_region
  #alias   = "us-east-1"
}
