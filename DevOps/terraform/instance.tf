module "instance" {
  source            = "./modules/instance"
  instance_type     = var.instance_type
  frontend_app_port = var.frontend_app_port
  resource_prefix   = local.resource_prefix
  instance_ami      = local.instance_ami
  vpc_id            = module.network.vpc_id
  subnet_id         = module.network.public_subnet
  azs_available     = slice(data.aws_availability_zones.available.names, 0, length(data.aws_availability_zones.available.names))
}
