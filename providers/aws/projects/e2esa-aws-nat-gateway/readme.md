
## Author
This project is maintained by '[end-to-end Solution Architect](https://e2esolutionarchitect.com/)'. Please feel free to drop a note to contactus@e2eSolutionArchitect.com for any queries

## Permission
end-to-end Solution Architect forum is contributing this as knowledge sharing. You are free to use and modify this.

## About the project
### EC2 Autoscaling

add architecture diagram if application

Rename app_tfvars file name to as app.tfvars and then execute  below command
```
 terraform apply -var-file="app.tfvars" -var="createdby=e2esa"
```

## Requirements

| Name  | Version |
| ------ | ------- |
| terraform | ~> 1.1.6 |
| aws | ~> 4.5.0 |

## Providers

| Name  | Version |
| ------ | ------- |
| aws | ~> 4.5.0 |


| Type  | Name | Identifier | Source |
| ------ | ------- | ------ | ------- |
| module | "aws_lb" |  | "../../modules/e2esa-module-aws-elb", main.tf |
| resource | "aws_launch_template" | "this" | autoscaling.tf |

## Inputs

| Name  | Description | Type | Default | Required |
| ------ | ------- | ------ | ------- | ------- |
| project | Project name  | string  | "e2esa-tutorials" | true | 
| aws_region | region  | string | "us-east-1" | true | 

## Outputs
| Name  | Description | 
| ------ | ------- |
| ecs_cluster_arn | Cluster arn |
| ecs_cluster_name | Cluster name |

## Notes
- Please check repository https://github.com/e2eSolutionArchitect/terraform
- We encourage you to contribute your knowledge with us and create a stronger IT community.

