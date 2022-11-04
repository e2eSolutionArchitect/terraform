
# terraform apply -var-file="app.tfvars" -var="createdBy=e2esa"

locals {
  name = "${var.project}-${var.prefix}"
  tags = {
    Project     = var.project
    CreatedBy   = var.createdBy
    CreatedOn   = timestamp()
    Environment = terraform.workspace
  }
}

module "aws_lb" {
  source = "../../modules/e2esa-module-aws-elb"
  tags   = local.tags
}