
provider "aws" {
  region = "us-east-2"
}

# backend for state
terraform {
  backend "s3" {
  encrypt = true
  bucket = "gruntwork-tf-part3"
  dynamodb_table = "gruntwork-tf-part3-statelock"
  region = "us-east-2"
  key = "stage/services/backend-app/terraform.tfstate"
 }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "gruntwork-tf-part3"
    key = "stage/vpc/terraform.tfstate"    
    region = "us-east-2"
  }
}

#resource "aws_elb" "example" {
#  name = "example"
#  subnets = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]
#}

# test ec2 instance
resource "aws_instance" "stage-backend-app-instance" {
 ami = "ami-965e6bf3"
 instance_type = "t2.micro"

 tags {
  Name = "stage-backend-app-instance"
 }
}

