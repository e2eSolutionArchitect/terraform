
## Author
This project is maintained by '[end-to-end Solution Architect](https://e2esolutionarchitect.com/)'. Please feel free to drop a note to contactus@e2eSolutionArchitect.com for any queries

## Permission
end-to-end Solution Architect forum is contributing this as knowledge sharing. You are free to use and modify this.

## About the project
### EC2 Autoscaling

<img width="1433" alt="image" src="https://user-images.githubusercontent.com/62712515/187027488-697eed70-2213-48f7-b70c-a98a2920e7b2.png">


- This project will provision a complete fleet of EC2 with Autoscaling. 
- The instances will be spread across all AZs (as per provided subnets) for High Availability
- CloudWatch alarm for scale up and scale down will trigger the scaling up/down policy
- Launch template will provision the instances as per given specification and user-data
- ELB will be provisioned and attached to Autoscaling group
- ASG is aligned with ELB health check. 
- ELB health check will fail for any unhealthy instance and based on that auto scaling group will trigger provisioning new instance
- Instances will have httpd installed and it will be accessed though public ips. 

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


### While using LB with ASG (Auto Scaling Group) , the TG type  must be 'instance' not ip)

### If using 'network_interfaces' like below then DON't user 'vpc_security_group_ids' separately. use 'security_groups' under network_interfaces

### Instances showing unhealthy ?
- I hope you are not launching blank EC2. If yes atleast install httpd or apache2 for a webserver and your LB should have port 80
- Check your LB that it should include all the subnets where your instances could be available. 
- Check your security group. It must allow the port you are configuring in LB listener 

Here is this example we are creating LB port 80 (or any port). Installing apache2 for webserver. otherwise target Group will have all unhealthy instances and ASG will continue launching new instances. Eventhough you may find the instances are up&running under EC2 dashboard. 

## Notes
- Please check repository https://github.com/e2eSolutionArchitect/terraform
- We encourage you to contribute your knowledge with us and create a stronger IT community.
