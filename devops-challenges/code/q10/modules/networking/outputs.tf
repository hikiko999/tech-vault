output "public_subnet_ids" {
    value = aws_subnet.public[*].id
}

output "azs" {
    value = var.vpc_azs
}