output ec2_public_ip {
    value = module.compute.ec2_public_ip
}

output ec2_private_ip {
    value = module.compute.ec2_private_ip
}

output ec2_public_dns {
    value = module.compute.ec2_public_dns
}

output "ec2_public_dns_map" {
  value = module.compute.ec2_public_dns_map
}