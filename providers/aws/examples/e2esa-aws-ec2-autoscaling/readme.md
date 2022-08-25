

## README
- end-to-end Solution Architect forum is contributing this as knowledge sharing. You are free to use and modify this. 
- Please check repository https://github.com/e2eSolutionArchitect/terraform
- We encourage you to contribute your knowledge with us and create a stronger IT community.
- Please feel free to contract us at https://e2esolutionarchitect.com/

# rename app_tfvars file name to as app.tfvars and then execute  below command
```
 terraform apply -var-file="app.tfvars" -var="createdBy=e2esa"
```
### While using LB with ASG (Auto Scaling Group) , the TG type  must be 'instance' not ip)

### If using 'network_interfaces' like below then DON't user 'vpc_security_group_ids' separately. use 'security_groups' under network_interfaces

### Instances showing unhealthy ?
- I hope you are not launching blank EC2. If yes atleast install httpd or apache2 for a webserver and your LB should have port 80
- Check your LB that it should include all the subnets where your instances could be available. 
- Check your security group. It must allow the port you are configuring in LB listener 

Here is this example we are creating LB port 80 (or any port). Installing apache2 for webserver. otherwise target Group will have all unhealthy instances and ASG will continue launching new instances. Eventhough you may find the instances are up&running under EC2 dashboard. 

-