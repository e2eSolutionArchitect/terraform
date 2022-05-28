# Common
project = "e2esa-tutorials"

# General 
aws_region  = "us-east-1"
profile     = "production"
environment = "prd"

# Backend
backend_s3_bucket      = "somcloud-tf-states"
backend_dynamodb_table = "somcloud-tf-locks"

# ECS
create_ecs_cluster = true
ecs_cluster_name   = "e2esa-cluster-prd"
container_insights = true
