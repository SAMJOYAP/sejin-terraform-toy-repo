variable "app_namespace" {
  description = "Namespace for application workloads (frontend/backend)"
  type        = string
}

variable "db_namespace" {
  description = "Namespace for database workloads"
  type        = string
}

variable "backend_image" {
  description = "Backend container image"
  type        = string
}

variable "frontend_image" {
  description = "Frontend container image"
  type        = string
}

variable "backend_port" {
  description = "Backend container port"
  type        = number
}

variable "frontend_port" {
  description = "Frontend container port"
  type        = number
}

variable "db_image" {
  description = "Postgres image"
  type        = string
}

variable "db_name" {
  description = "Postgres database name"
  type        = string
}

variable "db_username" {
  description = "Postgres username"
  type        = string
}

variable "db_password" {
  description = "Postgres password"
  type        = string
  sensitive   = true
}

variable "db_storage_size" {
  description = "Postgres PVC size"
  type        = string
}

variable "storage_class_name" {
  description = "StorageClass name for Postgres PVC"
  type        = string
}

variable "create_storage_class" {
  description = "Whether to create the StorageClass"
  type        = bool
}

variable "ingress_class_name" {
  description = "IngressClass name (ALB)"
  type        = string
}

variable "alb_scheme" {
  description = "ALB scheme"
  type        = string
}

variable "alb_target_type" {
  description = "ALB target type"
  type        = string
}
