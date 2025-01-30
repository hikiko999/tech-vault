variable "ec2_ami" {
  type        = list(string)
  description = "AMI for EC2 instance"
}

variable "ec2_type" {
  type        = string
  description = "Type for EC2 Instance"
}

variable "ec2_tag_environment" {
  type        = map(string)
  description = "Environment tag for resources inside the VPC"
}