variable "region" {
  description = "Region for deployment"
  default = "eu-west-2"
}

variable "vpc_cidr" {
  description = "CIDR range to be used for VPC"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC. Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched."
  default = "default"
}


variable "client" {
  description = "Client for which infrastructure is to be created"
}

variable "environment" {
  description = "Environment for deployment"
  default = "dev"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "frontend_app_port" {
  default = 8080
}