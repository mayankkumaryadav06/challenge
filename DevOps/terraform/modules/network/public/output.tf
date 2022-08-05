output "nat_gateways" {
  value = aws_nat_gateway.nat.*.id
}

output "subnet" {
  value = aws_subnet.this.*.id
}