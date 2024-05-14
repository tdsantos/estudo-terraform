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