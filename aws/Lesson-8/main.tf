provider "aws" {
    region = "eu-central-1"
}

data "aws_availability_zones" "working" {}


output "data_aws_availabitity_zones" {
  value = data.aws_availability_zones.working.names
}


