data "aws_availability_zones" "available" {
  state = "available"
}

# Search the ami matching filter. Name: faceit-<app-name> and Version: <AMI-Version>
# Version contains git commit id so to know AMI is created against which commit
data "aws_ami" "frontend_aws_amis" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["faceit-${var.environment}-*"]
  }

}
