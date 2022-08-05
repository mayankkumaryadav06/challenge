# Creating VPC and subnets
module "network" {
  source = "./modules/network"

  vpc_cidr             = local.vpc_cidr
  env_name             = local.environment
  resource_prefix      = local.resource_prefix
  azs_available        = slice(data.aws_availability_zones.available.names, 0, length(data.aws_availability_zones.available.names))
  cidrs_public_subnet  = format("%s,%s,%s", cidrsubnet(var.vpc_cidr, 6, 0), cidrsubnet(var.vpc_cidr, 6, 2), cidrsubnet(var.vpc_cidr, 6, 4))
  cidrs_private_subnet = format("%s,%s,%s", cidrsubnet(var.vpc_cidr, 6, 1), cidrsubnet(var.vpc_cidr, 6, 3), cidrsubnet(var.vpc_cidr, 6, 5))
}
