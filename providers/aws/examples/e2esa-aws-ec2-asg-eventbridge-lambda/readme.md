
## Author
This project is maintained by '[end-to-end Solution Architect](https://e2esolutionarchitect.com/)'. Please feel free to drop a note to contactus@e2eSolutionArchitect.com for any queries

## Permission
end-to-end Solution Architect forum is contributing this as knowledge sharing. You are free to use and modify this.

## About the project
### CloudWatch EventBridge with EC2 Autoscaling group to execute SSM Run Command in EC2 on termination using ASG lifecycle hook. 

- There are times when we want to execute someting in EC2 before its' termination. Such as before termination take snapshot, copy log to s3, deregister that particular ec2 from domain or anything we want to execute before termination.

- There are two main things to achieve. Before terminating trigger the script and secondly hold the EC2 at termination state for sometime which the script is executing. That's why ASG lifecycle hook has been implemented. 


- This project will provision a complete fleet of EC2 with Autoscaling group, Lambda, CloudWatch log group, EventBridge, SNS, S3 bucket. 
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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_cloudwatch"></a> [aws\_cloudwatch](#module\_aws\_cloudwatch) | ../../modules/e2esa-module-aws-cloudwatch | n/a |
| <a name="module_aws_lambda"></a> [aws\_lambda](#module\_aws\_lambda) | ../../modules/e2esa-module-aws-lambda | n/a |
| <a name="module_aws_lb"></a> [aws\_lb](#module\_aws\_lb) | ../../modules/e2esa-module-aws-elb | n/a |
| <a name="module_aws_s3_bucket"></a> [aws\_s3\_bucket](#module\_aws\_s3\_bucket) | ../../modules/e2esa-module-aws-s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_lifecycle_hook.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_lifecycle_hook) | resource |
| [aws_autoscaling_policy.scale_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.scale_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_cloudwatch_event_rule.console](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_metric_alarm.scale_down_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.scale_up_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_sns_topic.aws_logins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_health_check_type"></a> [asg\_health\_check\_type](#input\_asg\_health\_check\_type) | n/a | `any` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | General | `any` | n/a | yes |   
| <a name="input_createdby"></a> [createdby](#input\_createdby) | n/a | `any` | n/a | yes |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | n/a | `any` | n/a | yes |
| <a name="input_enable_lifecycle_rule"></a> [enable\_lifecycle\_rule](#input\_enable\_lifecycle\_rule) | n/a | `any` | n/a | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | n/a | `any` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `any` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `any` | n/a | yes |
| <a name="input_lambda_alias_name"></a> [lambda\_alias\_name](#input\_lambda\_alias\_name) | n/a | `any` | n/a | yes |
| <a name="input_lambda_filename_zip"></a> [lambda\_filename\_zip](#input\_lambda\_filename\_zip) | Lambda | `any` | n/a | yes |
| <a name="input_lambda_func_current_version"></a> [lambda\_func\_current\_version](#input\_lambda\_func\_current\_version) | n/a | `any` | n/a | yes |
| <a name="input_lambda_func_target_version"></a> [lambda\_func\_target\_version](#input\_lambda\_func\_target\_version) | n/a | `any` | n/a | yes |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | n/a | `any` | n/a | yes |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | n/a | `any` | n/a | yes |
| <a name="input_lambda_role_arn"></a> [lambda\_role\_arn](#input\_lambda\_role\_arn) | n/a | `any` | n/a | yes |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | n/a | `any` | n/a | yes |
| <a name="input_lb_enable_deletion_protection"></a> [lb\_enable\_deletion\_protection](#input\_lb\_enable\_deletion\_protection) | n/a | `any` | n/a | yes |
| <a name="input_lb_internal"></a> [lb\_internal](#input\_lb\_internal) | n/a | `any` | n/a | yes |    
| <a name="input_lb_listener_port"></a> [lb\_listener\_port](#input\_lb\_listener\_port) | n/a | `any` | n/a | yes |
| <a name="input_lb_listener_protocol"></a> [lb\_listener\_protocol](#input\_lb\_listener\_protocol) | n/a | `any` | n/a | yes |
| <a name="input_lb_load_balancer_type"></a> [lb\_load\_balancer\_type](#input\_lb\_load\_balancer\_type) | n/a | `any` | n/a | yes |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | Load Balancer | `any` | n/a | yes |      
| <a name="input_lb_protocol"></a> [lb\_protocol](#input\_lb\_protocol) | n/a | `any` | n/a | yes |    
| <a name="input_lb_security_groups"></a> [lb\_security\_groups](#input\_lb\_security\_groups) | n/a | `any` | n/a | yes |
| <a name="input_lb_subnets"></a> [lb\_subnets](#input\_lb\_subnets) | n/a | `any` | n/a | yes |       
| <a name="input_lb_target_port"></a> [lb\_target\_port](#input\_lb\_target\_port) | n/a | `any` | n/a | yes |
| <a name="input_lb_target_type"></a> [lb\_target\_type](#input\_lb\_target\_type) | n/a | `any` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Auto Scaling | `any` | n/a | yes |    
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | n/a | `any` | n/a | yes |
y` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes || <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description ||------|-------------|
| <a name="output_asg_arn"></a> [asg\_arn](#output\_asg\_arn) | Auto Scaling Group ARN |


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
