resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.rds_username
  password             = var.rds_password
  skip_final_snapshot  = true

  tags = merge(
      var.rds_tags,
    {
      Terraform   = "true"
    }
  )
}