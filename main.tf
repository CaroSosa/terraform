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
  source = "./modules/networking"
  cidr_block = "10.0.0.0/16"
  Name = "Ravenclaw-lab4"
  cidr_block_subnet = ["10.0.1.0/24","10.0.64.0/24","10.0.128.0/24","10.0.192.0/24"]
  availability_zone = ["us-east-1a","us-east-1b"]
  Name_subnet = ["subnet-publica-1","subnet-publica-2", "subnet-privada-1", "subnet-privada-2" ]
  Name_IGW = "IGW-lab-tf"
  connectivity_type= "public"
  Name-NAT = ["NAT-lab-tf-1", "NAT-lab-tf-2"]
}