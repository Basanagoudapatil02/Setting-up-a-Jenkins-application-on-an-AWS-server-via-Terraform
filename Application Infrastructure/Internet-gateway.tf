resource "aws_internet_gateway" "custominternetgateway" {
  vpc_id = aws_vpc.customvpc.id
}
