variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "monitoring_namespace" {
  description = "Namespace for monitoring stack"
  type        = string
  default     = "monitoring"
}
