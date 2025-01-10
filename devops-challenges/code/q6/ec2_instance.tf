# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami

data "aws_ami" "amazon_linux_2" {
  most_recent = true # grabs most recent image
  owners      = ["amazon"]  # Use Amazon's account to find their official AMIs
  filter { # just a block, no equals
    name  = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Pattern to match Amazon Linux 2 AMIs
  }
}

resource "aws_instance" "tf-test-ec2-lcrosendo" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"

  tags = {
    Environment = "Dev"
  }
}