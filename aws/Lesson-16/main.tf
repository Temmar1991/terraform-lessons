provider "aws" {
  region = "ca-central-1"
}


variable "aws_users" {
  description = "List of IAM Users to create"
  default = ["vasya", "petya", "kolya","lena","masha", "misha", "vova"]
}

resource "aws_iam_user" "user1" {
  name = "pushkin"
}

resource "aws_iam" "users" {
  count = length("${var.aws_users}")  
  name = element("${var.aws_users}", count.index)
}



