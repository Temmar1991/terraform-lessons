provider "aws" {
  region = "ca-central-1"
}

provider "aws" {
  region = "us-east-1"
  alias = "USA"
}

provider "aws" {
  region = "eu-central-1"
  alias = "GER"
}

#============================================================

data "aws_ami" "amazon_default" {
  most_recent = true
  owners = ["amazon"]
  filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-*"]
  }
}

data "aws_ami" "amazon_usa" {
  probider = aws.USA
  most_recent = true
  owners = ["amazon"]
  filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-*"]
  }
}

data "aws_ami" "amazon_ger" {
  probider = aws.GER
  most_recent = true
  owners = ["amazon"]
  filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-*"]
  }
}


resource "aws_instance" "my_default_server" {
  instance_type = "t3.micro"
  ami = "${data.aws_ami.amazon_default.id}"
  tags = {
      Name = "Default server"
  }
}


resource "aws_instance" "my_usa_server" {
  provider = aws.USA
  instance_type = "t3.micro"
  ami = "${data.aws_ami.amazon_usa.id}"
  tags = {
      Name = "USA server"
  }
}

resource "aws_instance" "my_ger_server" {
  provider = aws.GER
  instance_type = "t3.micro"
  ami = "${data.aws_ami.amazon_ger.id}"
  tags = {
      Name = "GERMANY server"
  }
}