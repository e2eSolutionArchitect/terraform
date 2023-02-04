terraform {
  required_version = "~> 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37.0"
    }
  }

  # TF State Management
  # Variables not allowed in backend block. 
  backend "s3" {
    bucket         = "e2esa-tf-states"
    key            = "s3-backend/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "e2esa-tf-locks"
    encrypt        = true
    profile        = "default2"
  }
}

# provider block

provider "aws" {
  profile = "default2"
  #shared_credentials_file ="/path/to/.aws/credentials"
  region = var.aws_region
  #alias   = "us-east-1"
}
