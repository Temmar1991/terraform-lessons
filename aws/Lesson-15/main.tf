provider "aws" {
  region = "eu-central-1"
}


variable "env" {
  default = "prod"
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
}

