
# terraform apply -var-file="app.tfvars" -var="createdBy=e2esa"

locals {
  tags = {
    Project     = var.project
    CreatedBy   = var.createdBy
    CreatedOn   = timestamp()
    Environment = terraform.workspace
  }
}

module "aws_codedeploy" {
  source               = "../../modules/e2esa-module-aws-codedeploy"
  cd_app_name=var.cd_app_name
  trigger_name=var.trigger_name
  alarms=var.alarms
  deployment_config_name=var.deployment_config_name
  tags                 = local.tags
}