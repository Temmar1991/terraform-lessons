provider "aws" {
    region = "eu-central-1"
}


data "aws_ami" "latest_ubuntu" {
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  
}

data "aws_ami" "latest_amazon_linux" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-*"]
  }
  
}

data "aws_ami" "latest_windows_server" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["Windows_Server-2016-English-Full-Base-*"]
  }
  
}


output "latest_ubuntu_ami_id" {
  value = "${data.aws_ami.latest_ubuntu.id}"
}

output "latest_ubuntu_ami_name" {
  value = "${data.aws_ami.latest_ubuntu.name}"
}

output "latest_amazon_linux_id" {
  value = "${data.aws_ami.latest_amazon_linux.id}"
}

output "latest_amazon_linux_name" {
  value = "${data.aws_ami.latest_amazon_linux.name}"
}

output "latest_windows_server_id" {
  value = "${data.aws_ami.latest_windows_server.id}"
}

output "latest_windows_server_name" {
  value = "${data.aws_ami.latest_windows_server.name}"
}




