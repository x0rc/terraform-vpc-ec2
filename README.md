# Terraform VPC-EC2 Module

This configuration directory creates a Web Server from scratch - Amazon EC2 and a basic VPC for networking.

This are reusable Terraform modules that can be applied across different regions.

## Resources:

- [VPC Module](./modules/vpc)
>- aws_vpc
>- aws_subnet
>- aws_internet_gateway
>- aws_route_table
>- aws_route_table_association
>- aws_security_group

- [EC2 Module](./modules/ec2)
>- aws_instance

---

## Prerequisites:
Before you start, go to Amazon Console and create the key pair in the desired region.
 - AWS Account
 - Terraform CLI
 - key pair
---

## Possible changes:
- make it more dynamic -> more variables
- create outputs
- create private network
- automate the keys thing
- do some work on tagging..

---

## Usage:
```bash
terraform init
...
terraform plan
var.aws_region
  Enter a value: <INSERT REGION>

var.key_name
  Enter a value: <YOUR KEY NAME HERE>
...
terraform apply
var.aws_region
  Enter a value: <INSERT REGION>

var.key_name
  Enter a value: <YOUR KEY NAME HERE>  

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.
```

---

Use `./clean.sh` when you are done. 
