
resource "aws_subnet" "this" {
  count                   = length(split(",", var.cidrs_private_subnet))
  cidr_block              = element(split(",", var.cidrs_private_subnet), count.index)
  vpc_id                  = var.vpc_id
  availability_zone       = var.azs_available[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.resource_prefix}-private-subnet"
  }
}

resource "aws_route_table" "private_routing_table" {
  count  = length(split(",", var.cidrs_private_subnet))
  vpc_id = var.vpc_id
}

resource "aws_route" "private_routes" {
  count                  = length(split(",", var.cidrs_private_subnet))
  route_table_id         = aws_route_table.private_routing_table.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateways[count.index]
}

resource "aws_route_table_association" "route_association" {
  count          = length(split(",", var.cidrs_private_subnet))
  route_table_id = aws_route_table.private_routing_table.*.id[count.index]
  subnet_id      = aws_subnet.this.*.id[count.index]
}