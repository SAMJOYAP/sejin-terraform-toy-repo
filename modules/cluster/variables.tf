variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
}

variable "cluster_public_access_cidrs" {
  description = "Allowed CIDRs for EKS public API endpoint"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for cluster and node groups"
  type        = list(string)
}

variable "node_instance_type" {
  description = "Managed node group instance type"
  type        = string
}

variable "node_min_size" {
  description = "Managed node group min size"
  type        = number
}

variable "node_max_size" {
  description = "Managed node group max size"
  type        = number
}

variable "node_desired_size" {
  description = "Managed node group desired size"
  type        = number
}

variable "create_cloudwatch_log_group" {
  description = "Whether to create the EKS CloudWatch log group"
  type        = bool
}
