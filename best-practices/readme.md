
# Terraform scripting Best Practices and Guidelines

Select any project of your choice from our [terraform project repo](https://github.com/e2eSolutionArchitect/terraform/tree/main/providers/) and understanding the anatomy.

## Resource tagging standards & techniques
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
### add tags for resources
```
tags        = merge({ "resourcename" = "${local.name}-${var.suffix}" }, local.tags)
```
