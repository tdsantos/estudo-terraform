terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.49.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"
  name    = var.aws_vpc_name
  cidr    = var.aws_vpc_cidr

  azs             = var.aws_vpc_azs
  private_subnets = var.aws_vpc_private_subnets
  public_subnets  = var.aws_vpc_public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = var.aws_project_tags
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.10.0"

  cluster_name    = var.aws_eks_name
  cluster_version = var.aws_eks_version

  enable_cluster_creator_admin_permissions = true

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.default_vpc_id

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      min_size     = 2
      max_size     = 2
      desired_size = 2

      instance_types = var.aws_eks_managed_node_groups_instance_types
    }
  }
}

variable "aws_region" {
  description = "Região utilizada para criar os recursos da AWS"
  type        = string
  nullable    = false
}

variable "aws_vpc_name" {
  description = "Nome da vpc"
  type        = string
  nullable    = false
}

variable "aws_vpc_cidr" {
  description = "Cidr block da vpc"
  type        = string
  nullable    = false
}

variable "aws_vpc_azs" {
  description = "Vpc availability zones"
  type        = set(string)
  nullable    = false
}

variable "aws_vpc_private_subnets" {
  description = "Vpc pr"
  type        = set(string)
  nullable    = false
}

variable "aws_vpc_public_subnets" {
  description = "Vpc public subnets"
  type        = set(string)
  nullable    = false
}

variable "aws_eks_name" {
  description = "EKS Name"
  type        = string
  nullable    = false
}

variable "aws_eks_version" {
  description = "Eks version"
  type        = string
  nullable    = false
}

variable "aws_eks_managed_node_groups_instance_types" {
  description = "Node Groups"
  type        = set(string)
  nullable    = false
}

variable "aws_project_tags" {
  description = "Tags"
  type        = map(any)
  nullable    = false
}