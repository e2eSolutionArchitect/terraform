# Visit e2eSolutionArchitect.com | info@SolutionArchitect.com

## This is a sample Terraform file to check CHECKOV
## Run checkov 
## checkov --directory /user/path/to/iac/code
## checkov --file /user/tf/example.tf
## checkov -f /user/cloudformation/example1.yml -f /user/cloudformation/example2.yml

# refer https://www.checkov.io/2.Basics/Installing%20Checkov.html

locals {
  sg_name    = "checkov-test"
  aws_vpc_id = "vpc-#####" #enter vpc id here
  cidr_block = ["0.0.0.0/0"]
  from_port  = "80"
  to_port    = "80"
}

resource "aws_security_group" "this" {
  name        = local.sg_name
  description = "Security group "
  vpc_id      = local.aws_vpc_id

  ingress {
    description = "Ingress from VPC"
    from_port   = local.from_port
    to_port     = local.to_port
    protocol    = "tcp"
    cidr_blocks = local.cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

terraform {
  required_version = "~> 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20.0"
    }
  }
}

# provider block

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

