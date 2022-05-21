terraform {
  required_version = "~> 1.1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
}

# provider block

provider "aws" {
  profile = "production"
  #shared_credentials_file ="/path/to/.aws/credentials"
  region = var.aws_region
  #alias   = "us-east-1"
}
