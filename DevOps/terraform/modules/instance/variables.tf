variable "resource_prefix" {
  description = "All resource prefix"
}

variable "instance_ami" {
  description = "AMI ID to be used in launch configuration"
}

variable "instance_type" {
  description = "Type of instance to be used"
  default = "t2.micro"
}

variable "azs_available" {
  description = "AZs where instances will be deployed"
}

variable "instance_asg_max" {
  description = "Max size for ASG"
  default     = 1
}

variable "instance_asg_min" {
  description = "Min size for ASG"
  default     = 1
}

variable "instance_asg_desired" {
  description = "Desired size for ASG"
  default     = 1
}

variable "frontend_app_port" {
  description = "Port on which application is running"
}

variable "vpc_id" {
  description = "VPC on which instances will be deployed"
}

variable "subnet_id" {
  description = "Subnet ID in VPC where instances will be deployed. We using public subnet for instances"
}

variable "hc_path" {
  description = "Path for health-check"
  default     = "/health"
}

variable "hc_protocol" {
  description = "Protocol for health-check"
  default     = "HTTP"
}
