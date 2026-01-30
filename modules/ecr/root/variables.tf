variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "nodejs_repo_name" {
  description = "ECR repo name for Node.js backend"
  type        = string
  default     = "my-node"
}

variable "react_repo_name" {
  description = "ECR repo name for React frontend"
  type        = string
  default     = "my-react-vite"
}
