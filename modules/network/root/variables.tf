variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "ksy-learn-eks"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_s3_endpoint" {
  description = "Enable S3 gateway endpoint to reduce NAT traffic"
  type        = bool
  default     = true
}
