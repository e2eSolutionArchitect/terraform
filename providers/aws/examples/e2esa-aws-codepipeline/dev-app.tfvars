# terraform apply -var-file="dev-app.tfvars"

# Common
project = "e2esa-tutorials"

# General 
aws_region = "us-east-1"
createdBy  = "e2esa"


project_name             = "e2esa-codebuild"
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
vpc_id                       = "vpc-9d5256e7"
subnets                      = ["subnet-082dd857"]
security_group_ids           = ["sg-0ff9b8fca827bb31b"]
source_location              = "https://github.com/e2eSolutionArchitect/tf-codepipeline.git"


s3_bucket_id="e2esa-tf-codepipeline"
full_repository_id="e2eSolutionArchitect/tf-codepipeline"
codestar_connector_credentials="arn:aws:codestar-connections:us-east-1:306442480424:connection/cd9d26df-0a50-4989-ba9d-cce4adfa3c43"