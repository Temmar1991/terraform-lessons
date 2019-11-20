provider "aws" {
  region = "eu-central-1"
}


variable "env" {
  default = "dev"
}

variable "prod_owner" {
    default = "Artem Melnyk"
  
}

variable "noprod_owner" {
  default = "Dyadya Vasya"
}


variable "eec2_size" {
  default =  {
      "prod" = "t3.medium"
      "dev" = "t3.micro"
      "staging" = "t3.small"
  }
}


variable "allow_port_list" {
    default = {
        "prod" = ["80", "443"]
        "dev" = ["80", "443", "8080", "22"]

    }
  
}

data "aws_ami" "amazon_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
      name = "name"P
      values = ["amzn2-ami-hvm-*-x86_64-*"]
  }
}


resource "aws_instance" "my_webserver1" {
  ami = "${data.aws_ami.amazon_ami.id}"
#   instance_type = (var.env == "prod" ? "t2.large" : "t2.micro")
  instance_type = "${var.env}" == "prod" ? "${var.eec2_size["prod"]}" : "${var.eec2_size["dev"]}"

  tags = {
      Name = "${var.env}-server"
      Owner = "${var.env}" == "prod" ? "${var.prod_owner}" : "${var.noprod_owner}"

  }
}

resource "aws_instance" "my_webserver2" {
  ami = "${data.aws_ami.amazon_ami.id}"
  instance_type = lookup("${var.eec2_size}", "${var.env}")

  tags = {
      Name = "${var.env}-server"
      Owner = "${var.env}" == "prod" ? "${var.prod_owner}" : "${var.noprod_owner}"

  }
}


resource "aws_instance" "my_dev_bastion" {
  count = "${var.env}" == "dev" ? 1 : 0
  ami = "${data.aws_ami.amazon_ami.id}"
  instance_type = "t2.micro"

  tags = {
      Name = "Bastion Server for Dev-Sever"
  }
}


resource "aws_security_group" "my_webserver-dynamic" {
  name = "WebServer Security Group"
  description = "My First SecurityGroup"
  

  dynamic "ingress" {
    for_each = lookup("${var.allow_port_list}", "${var.env}")
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServer Security Group"
    Owner = "Artem Melnyk"
  }

} 