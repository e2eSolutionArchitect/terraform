# terraform apply -var-file="dev-app.tfvars"

# Common
project = "e2esa-demo"
prefix ="eks"

# General 
aws_region = "us-east-1"
createdby  = "e2esa"


vpc_id = "vpc-9d5256e7"
nat_public_subnet_id="subnet-082dd857"

# EKS Cluster
cluster_name                         = "eks-cluster"
cluster_service_ipv4_cidr            = "172.20.0.0/16"
cluster_version                      = "1.23"
cluster_endpoint_private_access      = false
cluster_endpoint_public_access       = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

public_subnets = ["subnet-", "subnet-"]
private_subnets =["subnet-","subnet-"]


# EKS Manager
ami                         = "ami-08c40ec9ead489470" #Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-09-12
availability_zone           = "us-east-1a"
instance_type               = "t2.medium"
associate_public_ip_address = true
subnet_id                   = "subnet-"
vpc_security_group_ids      = ["sg-"]
key_name                    = "e2esa-kp"
iam_instance_profile        = "manager_iam_profile"
disable_api_termination     = false