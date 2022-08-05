# Provider Configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  access_key = "AKIA5SPDRARL5ZGW3MAV"
  secret_key = "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"
  default_tags {
    tags = {
      Environment = var.environment
      Name        = "faceit"
    }
  }
}