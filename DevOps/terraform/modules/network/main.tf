resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.resource_prefix}-vpc"
  }
}

module "private_subnet" {
  source               = "./private"
  vpc_id               = aws_vpc.this.id
  azs_available        = var.azs_available
  cidrs_private_subnet = var.cidrs_private_subnet
  resource_prefix      = var.resource_prefix
  vpc_cidr             = var.vpc_cidr
  nat_gateways         = module.public_subnet.nat_gateways
  depends_on           = [module.public_subnet]
}

module "public_subnet" {
  source              = "./public"
  vpc_id              = aws_vpc.this.id
  azs_available       = var.azs_available
  cidrs_public_subnet = var.cidrs_public_subnet
  resource_prefix     = var.resource_prefix
  vpc_cidr            = var.vpc_cidr
}
