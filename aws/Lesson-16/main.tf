provider "aws" {
  region = "ca-central-1"
}


variable "aws_users" {
  description = "List of IAM Users to create"
  default = ["vasya", "petya", "kolya","lena","masha", "misha", "vova"]
}

data "aws_ami" "amazon_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-*"]
  }
}

resource "aws_iam_user" "user1" {
  name = "pushkin"
}

resource "aws_iam_user" "users" {
  count = length("${var.aws_users}")  
  name = element("${var.aws_users}", count.index)
}

resource "aws_instance" "servers" {
  count = 3
  ami = "${data.aws_ami.amazon_ami.id}"
  instance_type = "t3.micro"
  tags = {
      Name = "Server Number ${count.index + 1}"
  }
}


output "created_iam_users_all" {
  value = aws_iam_user.users   
}
