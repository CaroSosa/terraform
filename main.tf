terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "caro-sosa"
    key    = "terraform-tfstate"
    region = "us-east-1"
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


module "networking" {
  source            = "./modules/networking"
  cidr_block        = var.cidr_block
  Name              = var.Name
  cidr_block_subnet = var.cidr_block_subnet
  availability_zone = var.availability_zone
  Name_subnet       = var.Name_subnet
  Name_IGW          = var.Name_IGW
  connectivity_type = var.connectivity_type
  Name-NAT          = var.Name-NAT
}