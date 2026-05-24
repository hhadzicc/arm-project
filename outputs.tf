output "vpc_id" {
  description = "ID kreiranog VPC-a."
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID public subnet-a."
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID private subnet-a."
  value       = aws_subnet.private.id
}

output "nat_gateway_elastic_ip" {
  description = "Elastic IP adresa dodijeljena NAT Gateway-u."
  value       = aws_eip.nat.public_ip
}

output "web_public_ip" {
  description = "Public IP web EC2 instance."
  value       = aws_instance.web.public_ip
}

output "web_public_dns" {
  description = "Public DNS web EC2 instance."
  value       = aws_instance.web.public_dns
}

output "db_private_ip" {
  description = "Private IP DB EC2 instance."
  value       = aws_instance.db.private_ip
}

output "ssh_to_web" {
  description = "Komanda za SSH pristup web instanci."
  value       = "ssh -i arm_key ubuntu@${aws_instance.web.public_ip}"
}

output "database_host_for_app" {
  description = "DB host koji aplikacija treba koristiti."
  value       = aws_instance.db.private_ip
}

output "database_port_for_app" {
  description = "DB port koji aplikacija treba koristiti."
  value       = var.db_port
}