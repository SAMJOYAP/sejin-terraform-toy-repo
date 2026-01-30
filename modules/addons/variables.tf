variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN for IRSA"
  type        = string
}

variable "lb_controller_namespace" {
  description = "Namespace for AWS Load Balancer Controller"
  type        = string
}

variable "enable_external_dns" {
  description = "Enable ExternalDNS addon"
  type        = bool
}

variable "external_dns_namespace" {
  description = "Namespace for ExternalDNS"
  type        = string
}

variable "domain_name" {
  description = "Root domain name for Route53/ExternalDNS"
  type        = string
}
