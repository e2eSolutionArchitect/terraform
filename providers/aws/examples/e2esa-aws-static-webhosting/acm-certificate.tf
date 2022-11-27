#------------------------------------------------------------------------------
# ACM Certificate
#------------------------------------------------------------------------------
resource "aws_acm_certificate" "cert" {
  count = var.create_acm_certificate ? 1 : 0

  domain_name               = "*.${var.domain_name}"
  subject_alternative_names = [var.domain_name]

  validation_method = "DNS"

  tags = merge({
    "Name" = "${var.domain_name}"
  }, local.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "acm_certificate_validation_records" {
  for_each = var.create_acm_certificate ? {
    for dvo in aws_acm_certificate.cert[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
  zone_id         = var.create_route53_hosted_zone ? aws_route53_zone.hosted_zone[0].zone_id : aws_route53_record.www.zone_id
}

resource "aws_acm_certificate_validation" "cert_validation" {
  # Dependency to guarantee that certificate and DNS records are created before this resource
  depends_on = [
    aws_acm_certificate.cert,
    aws_route53_record.acm_certificate_validation_records,
  ]

  count = var.create_acm_certificate ? 1 : 0

  certificate_arn         = aws_acm_certificate.cert[0].arn
  validation_record_fqdns = [for record in aws_route53_record.acm_certificate_validation_records : record.fqdn]
}