terraform {
  required_version = "~> 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37.0"
    }
  }
}

# provider block

provider "aws" {
  profile = "default2"
  #shared_credentials_file ="/path/to/.aws/credentials"
  region = var.aws_region
  #alias   = "us-east-1"
}
