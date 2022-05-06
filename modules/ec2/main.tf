provider "aws" {
    region = var.aws_region
}

resource "aws_instance" "test-webserver" {

	ami 				= var.ami_id
	instance_type 			= var.instances_type
	availability_zone		= "${var.aws_region}a"
	key_name 		 	= var.aws_key
    	vpc_security_group_ids 		= [var.sg_id]
    	subnet_id			= var.subnet_id
    	associate_public_ip_address 	= true

	user_data = <<EOF
			#!/bin/bash
			sudo apt-get update -y
			sudo apt-get install httpd -y
			sudo systemctl start apache2
			sudo systemctl enable apache2
			echo "<h1>deployed via terraform</h1>" | sudo tee /var/www/html/index.html

			EOF

	tags = {
	  Name = var.ec2_tag
	}


}
