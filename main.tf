provider "aws" {
    region = var.aws_region
}


module "my_vpc" {
	source = "./modules/vpc"
	aws_region = var.aws_region
	
	vpc_cidr = "10.10.0.0/16"
	vpc_id = module.my_vpc.my_vpc_id
	subnet_cidr = "10.10.10.0/24"
	subnet_id = module.my_vpc.my_subnet_id
	vpc_tag = "x0r VPC"
	subnet_tag = "Public Subnet"
	sg_tag = "Allowing ssh/ access."
	sg_name = "ssh_web"
	


}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "ec2_module" {
	
	source = "./modules/ec2"
	aws_region = var.aws_region
	ami_id = data.aws_ami.ubuntu.id
	instances_type = "t2.micro"
	aws_az = "${var.aws_region}a"
	aws_key = var.key_name
	subnet_id = module.my_vpc.my_subnet_id
	sg_id = module.my_vpc.my_security_group_id
	ec2_tag = "Web Server"
	sg_name = "test_sg"
}
