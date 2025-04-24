resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.customvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custominternetgateway.id
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.publicrt.id
}
