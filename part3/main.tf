# main.tf

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
  key = "terraform.tfstate"
 }
}

# dynamoDB for state locking
resource "aws_dynamodb_table" "gruntwork-tf-part3-statelock" {
 name = "gruntwork-tf-part3-statelock"
 hash_key = "LockID"
 read_capacity = 20
 write_capacity = 20

 attribute {
  name = "LockID"
  type = "S"
 }

 tags {
  Name = "gruntwork-tf-part3-statelock"
 }
}

# test ec2 instance
resource "aws_instance" "example" {
 ami = "ami-965e6bf3"
 instance_type = "t2.micro"

 tags {
  Name = "root-test-instance"
 }
}

