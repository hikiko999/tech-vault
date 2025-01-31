data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name  = "name"
    values = var.ec2_ami
  }
}

resource "aws_instance" "ec2" {
  count = 1
  subnet_id = element(var.ec2_subnets,count.index)
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"

  tags = merge(
      var.ec2_tags,
    {
      Terraform   = "true"
    }
  )
}