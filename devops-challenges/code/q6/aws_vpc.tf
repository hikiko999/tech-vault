resource "aws_vpc" "tf-test-vpc-lcrosendo" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "tf-test-subnet-lcrosendo" {
  vpc_id     = aws_vpc.tf-test-vpc-lcrosendo.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "tf-test-igw-lcrosendo" {
  vpc_id = aws_vpc.tf-test-vpc-lcrosendo.id
}

# already attached from previous step
# resource "aws_internet_gateway_attachment" "tf-test-igw-attachment-lcrosendo" {
#   internet_gateway_id = aws_internet_gateway.tf-test-igw-lcrosendo.id
#   vpc_id = aws_vpc.tf-test-vpc-lcrosendo.id
# }