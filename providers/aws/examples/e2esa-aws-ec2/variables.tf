
# Tags
variable "project" {}
variable "createdby" {}
# General 
variable "aws_region" {}

# EC2 
variable "ami" {}
variable "availability_zone" {}
variable "ec2_names" {}
variable "loop_cnt" {}

variable "lb_target_tags_map" {
  description = "Tag map for the LB target resources"
  type        = map(string)
  default     = {}
}