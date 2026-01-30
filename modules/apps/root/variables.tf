variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "app_namespace" {
  description = "Namespace for application workloads (frontend/backend)"
  type        = string
  default     = "app"
}

variable "db_namespace" {
  description = "Namespace for database workloads"
  type        = string
  default     = "database"
}

variable "backend_image" {
  description = "Backend container image"
  type        = string
  default     = "710232982381.dkr.ecr.ap-northeast-2.amazonaws.com/my-node:latest"
}

variable "frontend_image" {
  description = "Frontend container image"
  type        = string
  default     = "710232982381.dkr.ecr.ap-northeast-2.amazonaws.com/my-react-vite:latest"
}

variable "backend_port" {
  description = "Backend container port"
  type        = number
  default     = 3000
}

variable "frontend_port" {
  description = "Frontend container port"
  type        = number
  default     = 8080
}

variable "db_image" {
  description = "Postgres image"
  type        = string
  default     = "postgres:16"
}

variable "db_name" {
  description = "Postgres database name"
  type        = string
  default     = "mydb"
}

variable "db_username" {
  description = "Postgres username"
  type        = string
  default     = "myuser"
}

variable "db_password" {
  description = "Postgres password"
  type        = string
  default     = "qwer"
  sensitive   = true
}

variable "db_storage_size" {
  description = "Postgres PVC size"
  type        = string
  default     = "5Gi"
}

variable "storage_class_name" {
  description = "StorageClass name for Postgres PVC"
  type        = string
  default     = "gp2"
}

variable "create_storage_class" {
  description = "Whether to create the StorageClass"
  type        = bool
  default     = true
}

variable "ingress_class_name" {
  description = "IngressClass name (ALB)"
  type        = string
  default     = "alb"
}

variable "alb_scheme" {
  description = "ALB scheme"
  type        = string
  default     = "internet-facing"
}

variable "alb_target_type" {
  description = "ALB target type"
  type        = string
  default     = "ip"
}
