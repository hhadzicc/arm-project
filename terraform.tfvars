#KOMANDA ZA PUBLIC IP: powershell -Command "(Invoke-WebRequest -UseBasicParsing https://checkip.amazonaws.com).Content.Trim()"

aws_region          = "eu-central-1"
availability_zone   = "eu-central-1a"
project_name        = "arm-projekat"

vpc_cidr            = "10.10.0.0/16"
public_subnet_cidr  = "10.10.1.0/24"
private_subnet_cidr = "10.10.2.0/24"

instance_type       = "t3.micro"

domain_name         = "tim1.arm.com"

ssh_allowed_cidr    = "OVDJE_IDE_PUBLIC_IP/32"

db_name             = "armdb"
db_user             = "armuser"
db_password         = "ArmUserPass123!"
db_root_password    = "ArmRootPass123!"
db_port             = 3306