variable "rds_username" {
    type = string
    default = "foobar"
    description = "Username for RDS resource"
}

variable "rds_password" {
    type = string
    description = "Password for RDS resource"
}

variable "rds_tags" {
  type        = map(string)
  description = "Tags for RDS resource"
}

# Networking Module

variable "rds_vpc" {
  type = string
  description = "VPC assigned to RDS subnet group resource"
}

variable "rds_subnets" {
  type = list(string)
  description = "Subnets assigned to RDS subnet group resource"
}

variable "rds_sg" {
  type = list(string)
  description = "Id for RDS security group"
}