resource "aws_codebuild_project" "this" {
  name          = var.project_name
  description   = var.project_desc
  build_timeout = var.build_timeout
  service_role  = aws_iam_role.this.arn

  artifacts {
    type = var.artifacts_type
  }

  environment {
    compute_type                = var.environment_compute_type
    image                       = var.environment_image
    type                        = var.environment_type
    image_pull_credentials_type = var.image_pull_credentials_type
    privileged_mode             = var.privileged_mode_enabled
    # registry_credential {
    #   credential          = var.dockerhub_credentials
    #   credential_provider = var.credential_provider
    # }

    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = environment_variable.value.type
      }
    }
  }

  # Make sure the group name and stream names exist
  logs_config {
    cloudwatch_logs {
      group_name  = var.cw_group_name
      stream_name = var.cw_stream_name
    }

    # s3_logs {
    #   status   = var.s3_logs_status
    #   location = "${var.s3_bucket_id}/build-log"
    # }
  }

  source {
    type                = var.source_type
    location            = var.source_location
    git_clone_depth     = 1
    report_build_status = var.report_build_status
    buildspec           = file("${var.buildspec_file_absolute_path}")
    git_submodules_config {
      fetch_submodules = var.fetch_submodules
    }
  }

  source_version = var.source_version

  # If you are using private subnets for CodeBuild then only use VPC configureation. In that case VPC must have NAT gateway.
  # If you are simply using all public network then DONT'T use VPC config.  
  # vpc_config {
  #   vpc_id             = var.vpc_id
  #   subnets            = var.subnets
  #   security_group_ids = var.security_group_ids
  # }

  tags = merge({ "ResourceName" = "${var.project_name}" }, var.tags)
}
