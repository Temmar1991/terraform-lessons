provider "aws" {}

resource "aws_instance" "my_Ubuntu" {
  ami = "ami-0ac05733838eabc06"
  instance_type = "t3.micro"

  tags = {
    name = "My Ubuntu server"
    Owner = "Artem Melnyk"
    Project = "Terraform"
  }

}


resource "aws_instance" "my_amazon" {
  ami = "ami-00aa4671cbf840d82"
  instance_type = "t3.small"


  tags = {
    name = "My Amazon server"
    Owner = "Artem Melnyk"
    Project = "Terraform"
  }
}

