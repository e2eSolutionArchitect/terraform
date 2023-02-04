
#------------------------------------------------------------------------------
# Route53 Hosted Zone
#------------------------------------------------------------------------------
# Not ccreating any new Hosted Zone. 
# resource "aws_route53_zone" "hosted_zone" {
#   count = var.create_route53_hosted_zone ? 1 : 0

#   name = var.domain_name
#   tags = merge({
#     Name = "${var.domain_name}-hz"
#   }, local.tags)
# }

# Use data to get existing route53 hosting zone record

# Hosting Zone must exist. 
# Ensure you are connecting to proper AWS account where hosting zone in created. 
data "aws_route53_zone" "selected" {
  name         = var.domain_name
  private_zone = var.private_zone
}

# Integrate CF with 53 as A type record
resource "aws_route53_record" "www" {
  #zone_id = aws_route53_zone.primary.zone_id
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.domain_name
  type    = var.route53_record_type
  alias {
    name                   = module.cloudfront.domain_name
    zone_id                = module.cloudfront.hosted_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}

