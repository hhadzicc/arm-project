variable "aws_region" {
  description = "AWS region u kojem se kreira infrastruktura."
  type        = string
}

variable "project_name" {
  description = "Naziv projekta, koristi se za tagove i imena resursa."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR blok za VPC."
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR blok za public subnet."
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR blok za private subnet."
  type        = string
}

variable "availability_zone" {
  description = "Availability zone za subnete."
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "Javna IP adresa sa koje je dozvoljen SSH pristup, npr. 123.123.123.123/32."
  type        = string
}

variable "instance_type" {
  description = "Tip EC2 instance."
  type        = string
}

variable "domain_name" {
  description = "Domena aplikacije, npr. tim1.arm.com."
  type        = string
}

variable "db_name" {
  description = "Naziv baze."
  type        = string
}

variable "db_user" {
  description = "Korisnik baze."
  type        = string
}

variable "db_password" {
  description = "Password za korisnika baze."
  type        = string
  sensitive   = true
}

variable "db_root_password" {
  description = "Root password za MySQL bazu."
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Port baze."
  type        = number
  default     = 3306
}