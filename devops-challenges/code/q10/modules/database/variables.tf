variable "rds_username" {
    type = string
    default = "foobar"
    description = "Username for RDS resource"
}

variable "rds_password" {
    type = string
    description = "Password for RDS resourec"
}

variable "rds_tags" {
  type        = map(string)
  description = "Tags for RDS resource"
}