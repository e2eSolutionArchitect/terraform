# -------------------------------------------
# Common Variables
# -------------------------------------------

variable "aws_region" {
  description = "AWS infrastructure region"
  type        = string
  default     = null
}


variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}

# -------------------------------------------
# Loab Balancer
# -------------------------------------------

variable "name" {
  description = "LB name"
  type        = string
  default     = "lb"
}

variable "internal" {
  description = "Internal true or false"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Application or Network type LB"
  type        = string
  default     = "application"
}

variable "security_groups" {
  description = "LB security groups"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "LB subnets"
  type        = list(string)
  default     = []
}

variable "enable_deletion_protection" {
  description = "enable_deletion_protection true or false"
  type        = bool
  default     = false
}


variable "lb_target_port" {
  description = "lb_target_port 80 or 443"
  type        = number
  default     = 80
}

variable "lb_protocol" {
  description = "lb_protocol HTTP (ALB) or TCP (NLB)"
  type        = string
  default     = "HTTP"
}

variable "lb_target_type" {
  description = "Target type ip (ALB/NLB), instance (Autosaling group)"
  type        = string
  default     = "ip"
}

variable "vpc_id" {
  description = "vpc_id"
  type        = string
  default     = null
}

variable "lb_listener_port" {
  description = "lb_listener_port"
  type        = number
  default     = 80
}

variable "lb_listener_protocol" {
  description = "lb_listener_protocol HTTP, TCP, TLS"
  type        = string
  default     = "HTTP"
}



variable "lb_target_tags_map" {
  description = "Tag map for the LB target resources"
  type        = map(string)
  default     = {}
}
