provider "aws" {
  region = "ca-central-1"
}


data "terraform_remote_state" "network" {
    backend = "s3"
    config = {
        bucket = "amelnyk-terraform-state"
        key = "dev/network/terraform.tfstate"
        region = "eu-central-1"
    }
}


resource "aws_security_group" "webserver" {
  
  name = "WebServer Security Group"
  vpc_id = "$data.terraform_remote_state.network.outputs.vpc_id"

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




