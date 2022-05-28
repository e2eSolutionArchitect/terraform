# Common
project = "e2esa-tutorials"

# General 
aws_region  = "us-east-1"
profile     = "development"
environment = "dev"

# Backend
backend_s3_bucket      = "e2esa-tf-states"
backend_dynamodb_table = "e2esa-tf-locks"

# ECS
create_ecs_cluster = true
ecs_cluster_name   = "e2esa-cluster-dev"
container_insights = false
