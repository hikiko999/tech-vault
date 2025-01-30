terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46.0" # required by module.vpc
      #   version = "~> 4.67" # this or more than (~>)
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

module "networking" {
  source = "./modules/networking"

  vpc_name = "my-vpc"
  vpc_cidr = "10.0.0.0/16"

  vpc_azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  vpc_public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  vpc_tag_environment = {
    Environment = "dev"
  }
}