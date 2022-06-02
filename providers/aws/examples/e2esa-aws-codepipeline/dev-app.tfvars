# terraform apply -var-file="dev-app.tfvars"

# Common
project = "e2esa-tutorials"

# General 
aws_region = "us-east-1"
createdBy="e2esa"


project_name             = "e2esa_codebuild"
project_desc             = "e2esa codebuild project"
environment_compute_type = "BUILD_GENERAL1_SMALL"
environment_image        = "hashicorp/terraform:1.2.2"
environment_type         = "LINUX_CONTAINER"
dockerhub_credentials    = ""
credential_provider      = "SECRETS_MANAGER"
environment_variables = [
  {
    name  = "KEY"
    value = "VALUE"
    type  = "PLAINTEXT"
  }
]
report_build_status          = false
source_version               = "master"
buildspec_file_absolute_path = "./buildspec/plan-buildspec.yml"
vpc_id                       = "vpc-#########"
subnets                      = ["subnet-#########"]
security_group_ids           = ["sg-#########"]
source_location="https://github.com/e2eSolutionArchitect/tf-codepipeline.git"