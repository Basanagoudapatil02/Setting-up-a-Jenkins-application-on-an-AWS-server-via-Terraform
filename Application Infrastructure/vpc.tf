resource "aws_vpc" "customvpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "Custom vpc"
  }
}
