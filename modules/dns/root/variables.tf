variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "domain_name" {
  description = "Root domain name for Route53/ExternalDNS"
  type        = string
  default     = ""
}

variable "create_hosted_zone" {
  description = "Create Route53 hosted zone for domain_name"
  type        = bool
  default     = true
}

variable "enable_acm" {
  description = "Enable ACM certificate for domain_name"
  type        = bool
  default     = false
}

variable "acm_subject_alternative_names" {
  description = "SANs for ACM certificate"
  type        = list(string)
  default     = []
}
