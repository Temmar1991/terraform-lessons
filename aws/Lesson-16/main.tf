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

output "сreated_iam_users_ids" {
    value = aws_iam_user.users[*].id
}

output "created_iam_users_custom" {
  value = [
      for user in aws_iam_user.users:
      "Username: ${user.name} has ARN: ${user.arn}"
  ]
}

output "created_users_map" {
  value = {
      for user in aws_iam_user.users:
      user.unique_id => user.id 
  }
}

output "custom_if_length" {
  value = [
      for x in aws_iam_user.users:
      x.name
      if lenght(x.name) == 4
  ]
}


