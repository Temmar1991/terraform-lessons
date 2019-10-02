provider "aws" {}

data "aws_availabitity_zones" "working" {}


output "data_aws_availabitity_zones" {
  value = data.aws_availabitity_zones.working.names
}


