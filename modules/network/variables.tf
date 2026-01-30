variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "enable_s3_endpoint" {
  description = "Enable S3 gateway endpoint to reduce NAT traffic"
  type        = bool
}
