provider "aws" {
  region = "ca-central-1"
}

resource "aws_iam_user" "user1" {
  name = "pushkin"
}



