# Tags
variable "project" {}
variable "prefix" {}
variable "createdby" {}
variable "org_unit" {}
variable "business_unit" {}
variable "cost_center" {}
variable "appid" {}

# General 
variable "aws_region" {}


variable "vpc_id" {}

# EKS Manager
variable "ami" {}
variable "instance_type" {}
variable "associate_public_ip_address" {}
variable "availability_zone" {}
variable "subnet_id" {}
variable "vpc_security_group_ids" {}
variable "iam_instance_profile" {}
variable "disable_api_termination" {}

# NAT gateway
variable "nat_public_subnet_id" {}
variable "nat_private_subnet_id" {}


# EKS Cluster Input Variables
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
  default     = "eksdemo"
}

variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kubernetes cluster"
  type        = string
  default     = null
}

variable "cluster_version" {
  description = "Kubernetes minor version to use for the EKS cluster (for example 1.21)"
  type        = string
  default     = null
}

variable "key_name" {
  description = "keypair to connect ec2"
  type        = string
  default     = null
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "public_subnets" {
  description = "List of public subnets."
  type        = list(string)
  default     = [""]
}

variable "private_subnets" {
  description = "List of private subnets."
  type        = list(string)
  default     = [""]
}


# EKS Node Group Variables
## Placeholder space you can create if required


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
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}

variable "lb_target_tags_map" {
  description = "Tag map for the LB target resources"
  type        = map(string)
  default     = {}
}

# EKS OIDC ROOT CA Thumbprint - valid until 2037
variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}