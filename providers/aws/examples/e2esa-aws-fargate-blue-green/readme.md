
## Author
This project is maintained by '[end-to-end Solution Architect](https://e2esolutionarchitect.com/)'. Please feel free to drop a note to contactus@e2eSolutionArchitect.com for any queries

## Permission
end-to-end Solution Architect forum is contributing this as knowledge sharing. You are free to use and modify this.

## About the project
### ECS Fargate Blue Green Deployment

# This project is IN PROGRESS

Rename app_tfvars file name to as app.tfvars and then execute  below command
```
 terraform apply -var-file="app.tfvars" -var="createdby=e2esa"
```

## Requirements

| Name  | Version |
| ------ | ------- |
| terraform | ~> 1.3.0 |
| aws | ~> 4.5.0 |

## Providers

| Name  | Version |
| ------ | ------- |
| aws | ~> 4.5.0 |


| Type  | Name | Identifier | Source |
| ------ | ------- | ------ | ------- |
| module | "ecs_cluster" |  | "../../modules/e2esa-module-aws-ecs-cluster", main.tf |
| module | "aws_lb" | "this" | e2esa-module-aws-elb,main.tf |
| resource | "aws_autoscaling_group" | "this" | autoscaling.tf |
| resource | "aws_autoscaling_policy" | "scale_up" | autoscaling.tf |
| resource | "aws_cloudwatch_metric_alarm" | "scale_up_alarm" | autoscaling.tf |
| resource | "aws_autoscaling_policy" | "scale_down" | autoscaling.tf |
| resource | "aws_cloudwatch_metric_alarm" | "scale_down_alarm" | autoscaling.tf |

## Inputs

| Name  | Description | Type | Default | Required |
| ------ | ------- | ------ | ------- | ------- |
| project | Project name  | string  | "e2esa-tutorials" | true | 
| aws_region | region  | string | "us-east-1" | true | 
| profile | user profile | string | "development" | true | 
| environment | Environment | string  | "dev" | true | 
| backend_s3_bucket | state bucket | string | "tf_states" | true | 
| backend_dynamodb_table | state db table | string | "tf_locks" | true | 
| create_ecs_cluster | create custer | boolean | true | true | 
| ecs_cluster_name | cluster name  | string |"e2esa-cluster-dev"  | true | 
| container_insights | container insights | boolean | true | true | 

## Outputs
| Name  | Description | 
| ------ | ------- |
| ecs_cluster_id | Cluster Id  | 
| ecs_cluster_arn | Cluster arn |
| ecs_cluster_name | Cluster name |


## Notes
- Please check repository https://github.com/e2eSolutionArchitect/terraform
- We encourage you to contribute your knowledge with us and create a stronger IT community.
