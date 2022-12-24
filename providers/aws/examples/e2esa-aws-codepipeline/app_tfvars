# terraform apply -var-file="dev-app.tfvars"

# Common
project = "e2esa-tutorials"

# General 
aws_region = "us-east-1"
createdby  = "e2esa"


project_name             = "e2esa-cicdpipeline"
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
buildspec_file_absolute_path = "./buildspec/apply-buildspec.yml"
vpc_id                       = "vpc-####"
subnets                      = ["subnet-####"]
security_group_ids           = ["sg-####"]
source_location              = "https://github.com/e2eSolutionArchitect/tf-codepipeline.git"


s3_bucket_id       = "e2esa-tf-codepipeline"
full_repository_id = "e2eSolutionArchitect/tf-codepipeline"
#codestar_connector_credentials="arn:aws:codestar-connections:us-east-1:######:connection/######"
