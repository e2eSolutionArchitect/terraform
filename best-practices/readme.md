
# Terraform scripting Best Practices and Guidelines

Select any project of your choice from our [terraform project repo](https://github.com/e2eSolutionArchitect/terraform/tree/main/providers/) and understanding the anatomy.

## 1. Never add connection/credentials in terraform files
- It is a big security threat. never add credentials in tf project files. 
- [Check here](https://github.com/e2eSolutionArchitect/terraform/blob/main/providers/aws/projects/template-e2esa-aws/versions.tf) how to refer connection profile for AWS cloud.
- [Check here]() for the ways to keep your connection credentials secure.

```
# provider block

provider "aws" {
  profile = "default"
  region  = var.aws_region
}
```

## 2. Maintain project documentation

- It is a great practice to maintain documentation for every terraform project
- [Check here](https://github.com/e2eSolutionArchitect/terraform/tree/main/providers/aws/projects/template-e2esa-aws#readme) for sample documentation.
- Use [Terraform docs generator](https://github.com/e2eSolutionArchitect/terraform/blob/main/docs/terraform-docs-generator.md) for documentation.

***Avoid code inline documentation***
- Purpose of Infrastructure as Code is to reduce conventional documentation. No extra inline code comments required. Simplicity of the code and meaningful variable name should be enough.


## 3. Infrastructure Code scanning 

- Your Terraform scripting can have vulnerability for network or infrastructure.
- Use IaC scanning tools for automated scanning
- As referance use [***Checkov***](https://github.com/e2eSolutionArchitect/terraform/tree/main/checknov) as Infrastructure code scanning for Terraform.
- Check the [tutorial nere](https://www.youtube.com/watch?v=bAkwvmZ7OGA) for how to use ***Checkov*** for Terraform code scanning.


## 4. Resource tagging standards & techniques
- Every resource must be tagged appropriately with its assocoated project, org unit, cost center and environment. 
- It is great to have createdby and createdon tags also. 
- Tagging is most useful for resource filtering and cost analysis. 

```
locals {
  name = "${var.project}-${var.prefix}"
  tags = {
    project      = var.project
    orgunit      = var.org_unit
    businessunit = var.business_unit
    costcenter   = var.cost_center
    appid        = var.appid
    appname      = var.name
    desc         = var.desc
    tier         = var.tier
    createdby    = var.created_by
    createdon    = timestamp()
    env  = var.env
  }
}

```
***add tags for resources***
```
tags        = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
```


## 5. Setup variable naming convention
- Variable names should be unique in a project, meaningfull name and clearly readable. Readability is very important. the short and meaningful name reduces extra verbiage for documentation
- Please refer below examples for variable name. Just reading the variable name will give you the understanding of what & why
 
```
# Backend
variable "backend_s3_bucket_id" {}
variable "backend_dynamodb_table_name" {}

# ECS
variable "ecs_cluster_name" {}
```


## 6. Setup resource naming convention

```
Naming a compute instance
<prefix>-<resource-name>-<suffix>
vm-mywebapp-01

# prefix can be resource type/project name etc
```


## 7. Use module for every commonly used components
[Click here](https://www.youtube.com/watch?v=3Nuw4DnXkR8) for the tutorial
```
module "acm" {
 # Import module from local
  source = "../../modules/e2esa-module-aws-acm"
 # Import module from remote git
  source             = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-acm?ref=main"
  version = "~> 10.0"
  
```


## 8. Never share/commit your '*.tfvars' in public repository 

- If you are using public repository for your terraform repo then make sure you have *.tfvars restricted in .gitignore file. 
- e2eSA provided project's [app_tfvars](https://github.com/e2eSolutionArchitect/terraform/blob/main/providers/aws/projects/e2esa-aws-acm/app_tfvars) has all variables but dummy values. It is asked to rename the file to app.tfvars and add your values for the mentioned variables. 
- If you are using  private repository used by authorized people only then no issue. 


## 9. Don't skip output

- While creating module definition , expose outputs so you can use them in your main project
- In case of creating tf project please expose required outputs
- Please don't share the output details publicly. It may contain confidential details of infrastructure


## 10. Format code

- Before code commit please validate and format. 

```
terraform validate
terraform fmt # to format current directory *.tf files 
terraform fmt -recursive  # to format *.tf files in all sub directories

```

## 11. Validate your inputs

```
variable "cost_center" {
  description = "Cost center for billing"
  type        = string
  validation {
    condition     = length(var.cost_center) > 5 && substr(var.cost_center, 0, 3) == "CC-"
    error_message = "The cost_center value must be a valid Cost center id, starting with \"CC-\"."
  }
}
```
## 12. Always use IAM granular access strategy
[Click here](https://github.com/e2eSolutionArchitect/scripts/blob/main/aws/best-practices/aws-startup-policy.json) for a AWM policy to start with. 

:writing_hand: Feel free to contact and collaborate with us. You are welcome to contribute in our forum to build a better tomorrow. 

