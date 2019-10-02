#------------------------------------------------------------------------
# My Terraform  
#
# Build WebServer during Bootstrap
#-----------------------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_server_web" {
  ami = "ami-00aa4671cbf840d82"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]


  tags = {
    Name = "Server-Web"
  }

}

resource "aws_instance" "my_server_app" {
  ami = "ami-00aa4671cbf840d82"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]


  tags = {
    Name = "Server-Application"
  }

}

resource "aws_instance" "my_server_db" {
  ami = "ami-00aa4671cbf840d82"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]


  tags = {
    Name = "Server-Database"
  }

}

resource "aws_security_group" "my_webserver" {
  
  name = "My Security Group"
  
  dynamic "ingress" {
    for_each = ["80", "443", "22"]
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
    Name = "Web Server Security Group"
    Owner = "Artem Melnyk"
  }

}

