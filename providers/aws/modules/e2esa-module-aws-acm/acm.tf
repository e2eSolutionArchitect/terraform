resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name       #"example.com"
  validation_method = var.validation_method #"DNS"

  tags = merge(
    { "resourcename" = "${var.name}-cert" }, var.tags
  )

  lifecycle {
    create_before_destroy = true
  }
}