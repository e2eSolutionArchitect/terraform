## Resource tagging standards & techniques
- Every resource must be tagged appropriately with its associated project, org unit, cost center, and environment. 
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


```
variable "tag" {
type = map(any)
description = "A map of tags with default values"
default = { 
  owner = "e2eSolutionArchitect@gmail.com"
  business_unit = "BUNIT01"
  cost_center ="COSTC001"
  tire = "web"
  }
}
```
