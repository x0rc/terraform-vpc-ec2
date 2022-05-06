output "my_vpc_id" {
	value = aws_vpc.prod-vpc.id 
}

output "my_subnet_id" {
	value = aws_subnet.prod-subnet-1.id 
}

output "my_security_group_id" {
	value = aws_security_group.prod-sg.id 
}
