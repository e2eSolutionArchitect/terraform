
# Tags
variable "project" {}
variable "createdby" {}
variable "prefix" {}
# General 
variable "aws_region" {}

# Load Balancer
variable "lb_name" {}
variable "lb_internal" {}
variable "lb_load_balancer_type" {}
variable "lb_security_groups" {}
variable "lb_subnets" {}
variable "lb_enable_deletion_protection" {}
variable "lb_target_port" {}
variable "lb_protocol" {}
variable "lb_target_type" {}
variable "vpc_id" {}
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}

variable "lb_target_tags_map" {
  description = "Tag map for the LB target resources"
  type        = map(string)
  default     = {}
}