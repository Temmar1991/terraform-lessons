provider "aws" {
    region = "ca-central-1"
}


resource "aws_eip" "my_static_ip" {
    tags = {
        Name = "Static IP"
        Owner = "var.owner"
        Project = "${var.environment}-${var.project_name}"
    }
  
}
