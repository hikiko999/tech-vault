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