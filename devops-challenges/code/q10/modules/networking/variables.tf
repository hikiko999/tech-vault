variable "vpc_name" {
  type        = string
  description = "Name of the VPC resource"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR of the VPC resource"
}

variable "vpc_azs" {
  type        = list(string)
  description = "Availability zones for the subnets inside the VPC resource"
}

variable "vpc_private_subnets" {
  type        = list(string)
  description = "Private subnets inside the VPC resource"
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "Public subnets inside the VPC resource"
}

variable "vpc_tags" {
  type        = map(string)
  description = "Tags for VPC resources"
}