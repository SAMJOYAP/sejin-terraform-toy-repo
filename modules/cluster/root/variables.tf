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

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.35"
}

variable "cluster_public_access_cidrs" {
  description = "CIDRs allowed to access the EKS public endpoint"
  type        = list(string)
  default     = ["60.196.24.130/32"]
}

variable "node_instance_type" {
  description = "Managed node group instance type"
  type        = string
  default     = "t3.small"
}

variable "node_min_size" {
  description = "Managed node group min size"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Managed node group max size"
  type        = number
  default     = 2
}

variable "node_desired_size" {
  description = "Managed node group desired size"
  type        = number
  default     = 1
}

variable "create_cloudwatch_log_group" {
  description = "Whether to create the EKS CloudWatch log group"
  type        = bool
  default     = false
}
