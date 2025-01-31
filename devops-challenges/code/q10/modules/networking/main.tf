locals {

}

# Remote Modules

# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = merge(
      var.vpc_tags,
    {
      Terraform   = "true"
    }
  )
}