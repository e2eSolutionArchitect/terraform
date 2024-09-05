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
