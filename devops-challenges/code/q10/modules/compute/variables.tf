variable "ec2_ami" {
  type        = list(string)
  description = "AMI for EC2 resource"
}

variable "ec2_type" {
  type        = string
  description = "Type for EC2 resource"
}

variable "ec2_tags" {
  type        = map(string)
  description = "Tags for EC2 resource"
}

# From Outputs

variable "ec2_vpc" {
  type = string
  description = "VPC assigned to EC2 resource"
}

variable "ec2_subnets" {
  type        = list(string)
  description = "Subnet ids assigned to EC2 resource"
}

variable "ec2_azs" {
  type        = list(string)
  description = "Availability zones assigned to EC2 resource"
}