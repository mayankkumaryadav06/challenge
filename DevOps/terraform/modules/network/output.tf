output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet" {
  value = module.public_subnet.subnet
}