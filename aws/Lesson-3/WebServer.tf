#------------------------------------------------------------------------
# My Terraform  
#
# Build WebServer during Bootstrap
#-----------------------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
  ami = "ami-00aa4671cbf840d82"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = file("user-data.sh")

  tags = {
    Name = "Web Server Build by Terraform"
    Owner = "Artem Melnyk"
  }
    
}

resource "aws_security_group" "my_webserver" {
  name = "WebServer Security Group"
  description = "My First SecurityGroup"
  

  ingress {
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
