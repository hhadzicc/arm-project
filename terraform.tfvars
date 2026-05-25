#KOMANDA ZA PUBLIC IP: powershell -Command "(Invoke-WebRequest -UseBasicParsing https://checkip.amazonaws.com).Content.Trim()"

aws_region          = "us-east-1"
availability_zone   = "us-east-1a"
project_name        = "arm-projekat"

vpc_cidr            = "10.10.0.0/16"
public_subnet_cidr  = "10.10.1.0/24"
private_subnet_cidr = "10.10.2.0/24"

instance_type       = "t3.micro"

ssh_allowed_cidr    = "ip/32"

db_name             = "scenarijpro"
db_user             = "scenarijpro"
db_password         = "scenarijpro_password"
db_root_password    = "scenarijpro_root_password"
db_port             = 3306
domain_name         = "tim1.arm.com"