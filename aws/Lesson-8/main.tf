provider "aws" {
    region = "eu-central-1"
}

data "aws_availability_zones" "working" {}

data "aws_caller_identity" "current" {
  
}



output "data_aws_availabitity_zones" {
  value = data.aws_availability_zones.working.names[1]
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}



