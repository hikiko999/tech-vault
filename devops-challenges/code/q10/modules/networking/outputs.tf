output "main_vpc_name" {
    value = aws_vpc.main.tags["Name"]
    description = "Name of the main VPC resource"
}

# output "public_subnet_details" {
#     value = {
#         for subnet in aws_subnet.public :
#         subnet.tags["Name"] => {
#             vpc = aws_vpc.main.tags["Name"]
#             id = subnet.id
#             az = subnet.availability_zone
#         }
#     }
# }

output "public_subnet_ids" {
    value = aws_subnet.public[*].id
    description = "Ids for the subnet resources"
}

output "public_subnet_azs" {
    value = aws_subnet.public[*].availability_zone
    description = "Availability zones assigned to public subnet resources"
}