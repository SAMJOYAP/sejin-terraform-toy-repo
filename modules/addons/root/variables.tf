variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "lb_controller_namespace" {
  description = "Namespace for AWS Load Balancer Controller"
  type        = string
  default     = "kube-system"
}

variable "enable_external_dns" {
  description = "Enable ExternalDNS addon"
  type        = bool
  default     = false
}

variable "external_dns_namespace" {
  description = "Namespace for ExternalDNS"
  type        = string
  default     = "kube-system"
}

variable "domain_name" {
  description = "Root domain name for Route53/ExternalDNS"
  type        = string
  default     = ""
}
