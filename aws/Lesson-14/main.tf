provider "aws" {
  region = "ca-central-1"
}

resource "null_resource" "command1" {
  provisioner "local-exec" {
      command = "echo Terraform START: $(date) >> log.txt"
  }
}