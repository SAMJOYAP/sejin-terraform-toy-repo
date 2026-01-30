data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # Use two AZs for cost/control balance.
  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  # Small subnet ranges for a learning cluster.
  public_subnet_cidrs = [
    "10.0.0.0/20",
    "10.0.16.0/20",
  ]

  private_subnet_cidrs = [
    "10.0.128.0/20",
    "10.0.144.0/20",
  ]
}

# VPC with public/private subnets and NAT for private node egress.
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = local.azs
  public_subnets  = local.public_subnet_cidrs
  private_subnets = local.private_subnet_cidrs

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway      = true
  single_nat_gateway      = true
  map_public_ip_on_launch = true

  public_subnet_tags = {
    # Required for public-facing ALBs created by the AWS LB Controller.
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    # Required for internal load balancers and worker node placement.
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}

# Optional S3 gateway endpoint to reduce S3 data charges.
resource "aws_vpc_endpoint" "s3" {
  count = var.enable_s3_endpoint ? 1 : 0

  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = module.vpc.private_route_table_ids
}
