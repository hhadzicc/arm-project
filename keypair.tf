resource "aws_key_pair" "main" {
  key_name   = "${var.project_name}-key"
  public_key = file("${path.module}/arm_key.pub")

  tags = {
    Name    = "${var.project_name}-key"
    Project = var.project_name
  }
}