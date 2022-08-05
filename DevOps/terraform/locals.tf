locals {
  resource_prefix      = "${var.client}-${var.environment}"
  public_subnet_cidrs  = format("%s,%s,%s", cidrsubnet(var.vpc_cidr, 6, 0), cidrsubnet(var.vpc_cidr, 6, 2), cidrsubnet(var.vpc_cidr, 6, 3))
  private_subnet_cidrs = format("%s,%s,%s", cidrsubnet(var.vpc_cidr, 6, 4), cidrsubnet(var.vpc_cidr, 6, 5), cidrsubnet(var.vpc_cidr, 6, 6))
  azs_available        = slice(data.aws_availability_zones.available.names, 0, length(data.aws_availability_zones.available.names))
  instance_ami         = data.aws_ami.frontend_aws_amis.id
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
}
