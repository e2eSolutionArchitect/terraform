
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

## Terraform project specification 
[click here](tf-spec.md)

## Run terraform-docs to generate tf document
browse inside your terraform project directory and run the below command 

```
terraform-docs markdown table . > tf-spec.md
```


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
