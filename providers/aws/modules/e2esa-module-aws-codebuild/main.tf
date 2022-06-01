resource "aws_codebuild_project" "this" {
  name          = var.project_name #"test-project"
  description   = var.project_desc #"test_codebuild_project"
  build_timeout = var.build_timeout #"5"
  service_role  = aws_iam_role.this.arn

  artifacts {
    type = var.artifacts_type #"NO_ARTIFACTS"
  }

  cache {
    type     = var.cache_type #"S3"
    location = var.s3_bucket_name #aws_s3_bucket.this.bucket
  }

  environment {
    compute_type                = var.environment_compute_type #"BUILD_GENERAL1_SMALL"
    image                       = var.environment_image #"aws/codebuild/standard:1.0"
    type                        = var.environment_type #"LINUX_CONTAINER"
    image_pull_credentials_type = var.image_pull_credentials_type#"CODEBUILD"

   #for_each = var.environment_variables
    environment_variable {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }

    environment_variable {
      name  = "SOME_KEY2"
      value = "SOME_VALUE2"
      type  = "PARAMETER_STORE"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.cw_group_name
      stream_name = var.cw_stream_name
    }

    s3_logs {
      status   = var.s3_logs_status #"ENABLED"
      #location = "${aws_s3_bucket.this.id}/build-log"
      location = "${var.s3_bucket_name}/build-log"
    }
  }

  source {
    type            = var.source_type #"GITHUB"
    location        = var.source_location #"https://github.com/mitchellh/packer.git"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = var.source_version #"master"

  vpc_config {
    vpc_id = var.vpc_id #aws_vpc.this.id

    subnets = [var.subnets]

    security_group_ids = [var.subnets]
  }

tags = merge({ "ResourceName" = var.project_name }, var.tags)
}