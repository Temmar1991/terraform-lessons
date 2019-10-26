variable "region" {}


provider "aws" {
    region = "${var.region}"
}


data "aws_ami" "latest_amazon_linux" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-*"]
  }
  
}

resource "aws_eip" "my_static_ip" {
  instance = "${aws_instance.web_server.id}"

  tags = {
    Name = "Server IP"
    Owner = "Artem Melnyk"
    Project = "Phoenix"
    WhichRegion = "${var.region}"
  }
  
}


resource "aws_instance" "web_server" {
  ami = "${data.aws_ami.latest_amazon_linux.id}"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["${aws_security_group.my_webserver.id}"]

  tags = {
    Name = "Server Build By Terraform"
    Owner = "Artem Melnyk"
    Project = "Phoenix"
  }
}

resource "aws_security_group" "my_webserver" {
  
  name = "My Security Group"
  
  dynamic "ingress" {
    for_each = ["80", "443"]
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
    Name = "Server Security Group"
    Owner = "Artem Melnyk"
    Project = "Phoenix"
  }

}






