locals {
  tags = merge(
      var.vpc_tags,
    {
      Terraform   = "true"
    }
  )
}

# Main

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(
      local.tags,
      {
        Name = var.vpc_name
      }
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
      local.tags,
      {
        Name = "${aws_vpc.main.tags["Name"]}-main-igw"
      }
  )
}

# Public Subnets

resource "aws_subnet" "public" {
  count = length(var.vpc_public_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_public_subnets[count.index]
  availability_zone = element(var.vpc_azs,count.index)
  map_public_ip_on_launch = true

  tags = merge(
      local.tags,
      {
        Name = "${aws_vpc.main.tags["Name"]}-public-subnet[${count.index}]-${element(var.vpc_azs,count.index)}"
      }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  count = length(var.vpc_public_subnets)

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
      local.tags,
      {
        Name = "${aws_vpc.main.tags["Name"]}-public-rtb[${count.index}]-${element(var.vpc_azs,count.index)}"
      }
  )
}

resource "aws_route_table_association" "public" {
  count = length(var.vpc_public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

# Private Subnets

resource "aws_subnet" "private" {
  count = length(var.vpc_private_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_private_subnets[count.index]
  availability_zone = element(var.vpc_azs,count.index)

  tags = merge(
      local.tags,
      {
        Name = "${aws_vpc.main.tags["Name"]}-private-subnet[${count.index}]-${element(var.vpc_azs,count.index)}"
      }
  )
}

resource "aws_route_table" "private" {
  count = length(var.vpc_private_subnets)
  vpc_id = aws_vpc.main.id

  tags = merge(
      local.tags,
      {
        Name = "${aws_vpc.main.tags["Name"]}-private-rtb[${count.index}]-${element(var.vpc_azs,count.index)}"
      }
  )
}

resource "aws_route_table_association" "private" {
  count = length(var.vpc_private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# Remote Modules

# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = var.vpc_name
#   cidr = var.vpc_cidr

#   azs             = var.vpc_azs
#   private_subnets = var.vpc_private_subnets
#   public_subnets  = var.vpc_public_subnets

#   enable_nat_gateway = false
#   enable_vpn_gateway = false

#   tags = merge(
#       var.vpc_tags,
#     {
#       Terraform   = "true"
#     }
#   )
# }