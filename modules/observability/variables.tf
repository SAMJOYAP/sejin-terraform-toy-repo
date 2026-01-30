variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "monitoring_namespace" {
  description = "Namespace for monitoring stack"
  type        = string
}
