variable "domain_name" {
  description = "Root domain name for Route53/ExternalDNS (e.g. example.com)"
  type        = string
}

variable "create_hosted_zone" {
  description = "Create Route53 hosted zone for domain_name"
  type        = bool
}

variable "enable_acm" {
  description = "Enable ACM certificate for domain_name"
  type        = bool
}

variable "acm_subject_alternative_names" {
  description = "SANs for ACM certificate"
  type        = list(string)
}
