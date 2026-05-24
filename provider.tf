provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["${path.module}/credentials"]
  profile                  = "default"
}