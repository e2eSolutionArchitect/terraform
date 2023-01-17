
# Terraform scripting Best Practices and Guidelines

Select any project of your choice from our [terraform project repo](https://github.com/e2eSolutionArchitect/terraform/tree/main/providers/) and understanding the anatomy.

## 1. Resource tagging standards & techniques
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
    createdby    = var.createdby
    createdon    = timestamp()
    appid        = var.appid
    environment  = terraform.workspace
  }
}

```
***add tags for resources***
```
tags        = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
```

## 2. Use module for every commonly used components

```
module "acm" {
 # Import module from local
  source = "../../modules/e2esa-module-aws-acm"
 # Import module from remote git
  source             = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-acm?ref=main"
  
```

## 3. Never share/commit your '*.tfvars' in public repository 

- If you are using public repository for your terraform repo then make sure you have *.tfvars restricted in .gitignore file. 
- e2eSA provided project's [app_tfvars](https://github.com/e2eSolutionArchitect/terraform/blob/main/providers/aws/examples/e2esa-aws-acm/app_tfvars) has all params but dummy values. It is asked to rename the file to app.tfvars and add your values for the mentioned variables. 
- If you are using  private repository used by authorized people only then no issue. 

