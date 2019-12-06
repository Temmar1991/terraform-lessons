provider "aws" {
  region = "ca-central-1"
}

terraform {
  backend "s3" {
    bucket = "amelnyk-terraform-state"
    key = "dev/network/terraform.tfstate"
    region = "eu-central-1"
  }
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
      Name = "My VPC"
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}


#---------------------------------------------------------
output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}



