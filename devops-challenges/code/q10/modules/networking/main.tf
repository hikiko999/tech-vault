locals {
  tags = merge(
    var.vpc_tags,
    {
      Terraform = "true"
    }
  )
}

# Main

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

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
  count                   = length(var.vpc_public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_public_subnets[count.index]
  availability_zone       = element(var.vpc_azs, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    local.tags,
    {
      Name = "${aws_vpc.main.tags["Name"]}-public-subnet[${count.index}]-${element(var.vpc_azs, count.index)}"
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
      Name = "${aws_vpc.main.tags["Name"]}-public-rtb[${count.index}]-${element(var.vpc_azs, count.index)}"
    }
  )
}

resource "aws_route_table_association" "public" {
  count          = length(var.vpc_public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

# Private Subnets

resource "aws_subnet" "private" {
  count             = length(var.vpc_private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc_private_subnets[count.index]
  availability_zone = element(var.vpc_azs, count.index)

  tags = merge(
    local.tags,
    {
      Name = "${aws_vpc.main.tags["Name"]}-private-subnet[${count.index}]-${element(var.vpc_azs, count.index)}"
    }
  )
}

resource "aws_route_table" "private" {
  count  = length(var.vpc_private_subnets)
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.tags,
    {
      Name = "${aws_vpc.main.tags["Name"]}-private-rtb[${count.index}]-${element(var.vpc_azs, count.index)}"
    }
  )
}

resource "aws_route_table_association" "private" {
  count          = length(var.vpc_private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# Security Groups

resource "aws_security_group" "ec2_sg" {
  name        = "${aws_vpc.main.tags["Name"]}-ec2-sg"
  description = "Allow SSH and HTTP inbound traffic for EC2 (public subnet)"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.tags,
    {
      Name = "${aws_vpc.main.tags["Name"]}-ec2-sg"
    }
  )
}

resource "aws_security_group" "rds_sg" {
  name        = "${aws_vpc.main.tags["Name"]}-rds-sg"
  description = "Allow MySQL traffic for RDS (private subnet)"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block] # String to list
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = merge(
    local.tags,
    {
      Name = "${aws_vpc.main.tags["Name"]}-rds-sg"
    }
  )
}
