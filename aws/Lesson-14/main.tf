provider "aws" {
  region = "ca-central-1"
}

resource "null_resourse" "command1" {
  provisioner "local-execution" {
      command = "echo Terraform START: $(date) >> log.txt"
  }
}