provider "aws" {
  region = "eu-central-1"
}


variable "env" {
  default = "prod"
}

variable "prod_owner" {
    default = "Artem Melnyk"
  
}

variable "noprod_owner" {
  default = "Dyadya Vasya"
}



data "aws_ami" "amazon_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-*"]
  }
}


resource "aws_instance" "my_webserver1" {
  ami = "${data.aws_ami.amazon_ami.id}"
  instance_type = (var.env == "prod" ? "t2.large" : "t2.micro")

  tags = {
      Name = "${var.env}-server"
      Owner = "${var.env}" == "prod" ? "${var.prod_owner}" : "${var.noprod_owner}"

  }
}


resource "aws_instance" "my_dev_bastion" {
  count = "${var.env}" == "dev" ? 1 : 0
  ami = "${data.aws_ami.amazon_ami.id}"
  instance_type = t2.micro"

  tags = {
      Name = "Bastion Server for Dev-Sever"
  
  }
}
