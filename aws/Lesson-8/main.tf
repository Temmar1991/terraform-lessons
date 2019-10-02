provider "aws" {
    region = "eu-central-1"
}

data "aws_availability_zones" "working" {}

data "aws_caller_identity" "current" {
  
}

data "aws_region" "current" {}

data "aws_vpcs" "my_vpcs" {}

data "aws_vpc" "prod_vpc" {
  tags = {
      Name = "Prod"
  }
}

output "prod_vpc_id" {
  value = "${data.aws_vpc.prod_vpc.id}"
}

output "prod_vpc_cidr" {
  value = "${data.aws_vpc.prod_vpc.cidr_block}"
}


output "aws_vpcs" {
  value = "${data.aws_vpcs.my_vpcs.ids}"
}


output "data_aws_availabitity_zones" {
  value = data.aws_availability_zones.working.names[1]
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_region" {
  value = data.aws_region.current.name
}

output "data_aws_region_desc" {
  value = data.aws_region.current.description
}




