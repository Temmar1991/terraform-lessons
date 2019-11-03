provider "aws" {
  region = "ca-central-1"
}

data "aws_ami" "latest_amazon_linux" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-*"]
  }
  
}

resource "null_resource" "command1" {
  provisioner "local-exec" {
      command = "echo Terraform START: $(date) >> log.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
      command = "ping -c 5 www.google.com"
  }

  depends_on = [null_resource.command1]
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
      command = "print('Hello world!')"
      interpreter = ["python" , "-c"]
  }
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
      command = "echo $NAME1 $NAME2 $NAME3 >> names.txt"
      environment =  {
          NAME1 = "Vasya"
          NAME2 = "Petya"
          NAME3 = "Kolya"
      }
  }
}

resource "aws_instance" "myserver" {
  ami = "${data.aws_ami.latest_amazon_linux.id}"
  instance_type = "t3.micro"
  provisioner "local-exec" {
      command = "echo Hello from AWS Instance Creations!"
  }
}


resource "null_resource" "command6" {
  provisioner "local-exec" {
      command = "echo Terraform END: $(date) >> log.txt"

      depends_on = [null_resource.command1, null_resource.command2, null_resource.command3, null_resource.command4, aws_instance.myserver ]
  }
}
