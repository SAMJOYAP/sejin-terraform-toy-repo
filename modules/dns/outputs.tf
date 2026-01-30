output "hosted_zone_id" {
  value = local.hosted_zone_id
}

output "hosted_zone_name_servers" {
  value = var.create_hosted_zone && var.domain_name != "" ? aws_route53_zone.primary[0].name_servers : []
}

output "acm_certificate_arn" {
  value = var.enable_acm && var.domain_name != "" ? aws_acm_certificate.main[0].arn : ""
}
