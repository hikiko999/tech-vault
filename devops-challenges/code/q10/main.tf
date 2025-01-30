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
}