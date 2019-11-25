provider "aws" {
  region = "ca-central-1"
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


