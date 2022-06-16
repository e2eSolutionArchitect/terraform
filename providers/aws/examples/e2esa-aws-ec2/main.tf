# terraform apply -var-file="app.tfvars" -var="createdBy=e2esa"

locals {
  tags = {
    Project     = var.project
    CreatedBy   = var.createdBy
    CreatedOn   = timestamp()
    Environment = terraform.workspace
  }
}

module "e2esa-ec2" {
  source = "../../modules/e2esa-module-aws-ec2"
  for_each = toset(var.ec2_names) # toset(["ec21","ec22"])
  
  name = "${each.key}"
  tags =local.tags
}
