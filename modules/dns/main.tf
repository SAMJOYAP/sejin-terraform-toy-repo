resource "aws_route53_zone" "primary" {
  count = var.create_hosted_zone && var.domain_name != "" ? 1 : 0
  name  = var.domain_name
}

data "aws_route53_zone" "primary" {
  count        = !var.create_hosted_zone && var.domain_name != "" ? 1 : 0
  name         = var.domain_name
  private_zone = false
}

locals {
  hosted_zone_id = var.domain_name == "" ? "" : (
    var.create_hosted_zone ? aws_route53_zone.primary[0].zone_id : data.aws_route53_zone.primary[0].zone_id
  )
}

resource "aws_acm_certificate" "main" {
  count                     = var.enable_acm && var.domain_name != "" ? 1 : 0
  domain_name               = var.domain_name
  subject_alternative_names = var.acm_subject_alternative_names
  validation_method         = "DNS"
}

resource "aws_route53_record" "acm_validation" {
  for_each = var.enable_acm && var.domain_name != "" ? {
    for dvo in aws_acm_certificate.main[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  } : {}

  zone_id = local.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "main" {
  count                   = var.enable_acm && var.domain_name != "" ? 1 : 0
  certificate_arn         = aws_acm_certificate.main[0].arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}
