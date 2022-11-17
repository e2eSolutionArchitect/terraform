
# EIP output
output "eip_allocation_id" {
  description = "allocation_id"
  value       = try(aws_eip.this.allocation_id, "")
}

output "eip_association_id" {
  description = "association_id "
  value       = try(aws_eip.this.association_id, "")
}

output "eip_public_dns" {
  description = "eip_public_dns"
  value       = try(aws_eip.this.public_dns, "")
}

output "eip_private_dns" {
  description = "eip_private_dns"
  value       = try(aws_eip.this.private_dns, "")
}

output "eip_domain" {
  description = "domain"
  value       = try(aws_eip.this.domain, "")
}

# NAT Gateway output
output "natgw_allocation_id" {
  description = "allocation_id"
  value       = try(aws_nat_gateway.this.allocation_id, "")
}

output "natgw_connectivity_type" {
  description = "connectivity_type "
  value       = try(aws_nat_gateway.this.connectivity_type, "")
}


output "natgw_subnet_id" {
  description = "subnet_id"
  value       = try(aws_nat_gateway.this.subnet_id, "")
}


output "natgw_network_interface_id" {
  description = "network_interface_id"
  value       = try(aws_nat_gateway.this.network_interface_id, "")
}

output "natgw_private_ip" {
  description = "private_ip"
  value       = try(aws_nat_gateway.this.private_ip, "")
}

output "natgw_public_ip" {
  description = "private_ip"
  value       = try(aws_nat_gateway.this.private_ip, "")
}

# Route Table output
output "rt_id" {
  description = "id"
  value       = try(aws_route_table.this.id, "")
}

output "rt_arn" {
  description = "id"
  value       = try(aws_route_table.this.arn, "")
}