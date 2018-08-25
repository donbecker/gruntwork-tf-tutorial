
variable "env_prefix" {
  description = "prefix for resources"
  default = "prod"
}

provider "aws" {
  region = "us-east-2"
}

# backend for state
terraform {
  backend "s3" {
  encrypt = true
  bucket = "gruntwork-tf-part4-prod-state"
  dynamodb_table = "gruntwork-tf-part4-prod-statelock"
  region = "us-east-2"
  key = "terraform.tfstate"
 }
}

module "frontend" {
#  source = "../../gruntwork-tf-part4-infra-mods/modules/frontend-app"
  source = "git::git@github.com:donbecker/gruntwork-tf-part4-infra-mods//modules/frontend-app?ref=v1.0"

  env_prefix = "${var.env_prefix}"
  target_subnet_id = "${module.vpc.public_subnet_ids[0]}"
}

module "vpc" {
#  source = "../../gruntwork-tf-part4-infra-mods/modules/vpc"
  source = "git::git@github.com:donbecker/gruntwork-tf-part4-infra-mods//modules/vpc?ref=v1.0"

  env_prefix = "${var.env_prefix}"
}

