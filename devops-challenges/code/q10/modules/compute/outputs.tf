output ec2_public_ip {
    value = aws_instance.ec2[*].public_ip
}

output ec2_private_ip {
    value = aws_instance.ec2[*].private_ip
}

output ec2_public_ipv4_dns {
    value = aws_instance.ec2[*].public_ipv4_dns
}

# output "ec2_public_dns_map" {
#   value = { for k, v in aws_instance.ec2 : k => v.public_dns }
# }