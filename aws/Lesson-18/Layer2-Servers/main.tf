provider "aws" {
  region = "ca-central-1"
}

terraform {
  backend "s3" {
    bucket = "amelnyk-terraform-state"
    key = "dev/servers/terraform.tfstate"
    region = "eu-central-1"
  }
}

#=====================================================
data "terraform_remote_state" "network" {
    backend = "s3"
    config = {
        bucket = "amelnyk-terraform-state"
        key = "dev/network/terraform.tfstate"
        region = "eu-central-1"
    }
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-*"]
  }
}

#=======================================================


resource "aws_instance" "webserver" {
  ami = "${data.aws_ami.latest_amazon_linux.id}"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["${aws_security_group.webserver.id}"]
  subnet_id = "${data.terraform_remote_state.network.outputs.public_subnets_ids[0]}"
  user_data = <<EOF
  #! /bin/bash
  yum -y update
  yum -y install httpd
  myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
  echo "<h2>Web Server with ip $myip</h2><br>Build by Terraform with remote state" > /var/www/html/index.html
  chkconfig httpd on
  EOF
  tags = {
      Name = "WebServer"
  }
}


resource "aws_security_group" "webserver" {
  
  name = "WebServer Security Group"
  vpc_id = "${data.terraform_remote_state.network.outputs.vpc_id}"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${data.terraform_remote_state.network.outputs.vpc_cidr}"]
  }

  egress {
    from_port = 0
    to_port   = 0   
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "web-server-sg"
    Owner = "Artem Melnyk"
  }

}


output "network_details" {
  value = "${data.terraform_remote_state.network}"
}

output "webserver_sg_id" {
  value = "${aws_security_group.webserver.id}"
}


output "webserver_public_ip" {
  value = "${aws_instance.webserver.public_ipp}"
}





