provider "aws" {
    region = "ca-central-1"
}

locals {
  full_project_name = "${var.environment}-${var.project_name}"
  project_owner = "${var.owner} owner of ${var.project_name}"
}


resource "aws_eip" "my_static_ip" {
    tags = {
        Name = "Static IP"
        Owner = "var.owner"
        Project = "${local.full_project_name}"
        proj_owner = "${local.project_owner}"
    }
  
}
