terraform {
  required_version = "~> 1.1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }

  # TF State Management

  backend "s3" {
    bucket         = "e2esa-tf-states"
    key            = "ecs-cluster/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = var.backend_dynamodb_table
    encrypt        = true
    profile        = "default"
  }

}

# Provider block

provider "aws" {
  profile    = "default"
  region     = var.aws_region
  sts_region = var.aws_region
  assume_role {
    role_arn = "arn:aws:iam::<aws account name>:role/<rolename>"
  }
  endpoints {
    s3 = "s3.us-east-1.amazonaws.com"
  }
}
