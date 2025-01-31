locals {
    tags = merge(
      var.rds_tags,
    {
      Terraform   = "true"
    }
  )
}

resource "aws_db_subnet_group" "rds_sng" {
    name       = "${var.rds_vpc}.rds_sng"
    subnet_ids = var.rds_subnets

    tags = {
        Name = "${var.rds_vpc}-rds_sng"
    }
}

resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.rds_username
  password             = var.rds_password
  skip_final_snapshot  = true

  db_subnet_group_name = aws_db_subnet_group.rds_sng.name

  tags = merge(
      local.tags,
      { Name = "${var.rds_vpc}-rds" }
  )
}