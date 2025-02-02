terraform {
  backend "s3" {
    bucket         = "techvault-terraform-state"
    key            = "./terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "techvault-terraform-state-lock"
    acl            = "bucket-owner-full-control"
  }

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

# Resources are tagged with "Terraform = true" by default in the modules

module "networking" {
  source = "./modules/networking"

  vpc_name = "my-vpc"
  vpc_cidr = "10.0.0.0/16"

  vpc_azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  vpc_public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  vpc_tags = {
    Environment = "dev"
  }
}

module "compute" {
  source = "./modules/compute"

  ec2_ami  = ["amzn2-ami-hvm-*-x86_64-gp2"]
  ec2_type = "t2.micro"

  ec2_tags = {
    Environment = "dev"
  }

  ec2_vpc     = module.networking.main_vpc_name
  ec2_subnets = module.networking.public_subnet_ids
  ec2_azs     = module.networking.public_subnet_azs
  ec2_sg      = [module.networking.ec2_sg_id] # Requires List
}

module "database" {
  source = "./modules/database"

  rds_username = "foobar"
  rds_password = var.secret_rds_password

  rds_tags = {
    Environment = "dev"
  }

  rds_vpc     = module.networking.main_vpc_name
  rds_subnets = module.networking.public_subnet_ids
  rds_sg      = [module.networking.rds_sg_id]
}
