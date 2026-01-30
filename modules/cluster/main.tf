module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = var.cluster_public_access_cidrs
  cluster_endpoint_private_access      = true

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  create_cloudwatch_log_group = var.create_cloudwatch_log_group

  # Required for IAM roles for service accounts (IRSA).
  enable_irsa = true

  # Cost-minimized: disable KMS-backed secret encryption.
  cluster_encryption_config        = {}
  create_kms_key                   = false
  attach_cluster_encryption_policy = false

  eks_managed_node_groups = {
    default = {
      name           = "${var.cluster_name}-mng"
      instance_types = [var.node_instance_type]

      min_size     = var.node_min_size
      max_size     = var.node_max_size
      desired_size = var.node_desired_size

      disk_size = 20

      iam_role_additional_policies = {
        cloudwatch = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      }
    }
  }

  # Base addon for persistent volumes.
  cluster_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }
}
