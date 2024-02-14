output "public-ip" {
  value = aws_instance.public_instance.id
}

output "security-group-name" {
  value = aws_security_group.my_security.id
}

output "vpc-id" {
  value = aws_vpc.my_vpc.id
}

output "igw" {
  value = aws_internet_gateway.my_igw.id
}

output "punlic-instance-state" {
  value = aws_instance.public_instance.instance_state
}

output "private-instance-state" {
  value = aws_instance.private_instance.instance_state
}