
provider "aws" {
  region = "us-east-2"
}

variable "env_prefix" {
  description = "The prefix applied to resource names"
}

variable "target_subnet_id" {
  description = "The subnet to place resources in"
}

# test ec2 instance
resource "aws_instance" "frontend-app-instance" {
 ami = "ami-965e6bf3"
 instance_type = "t2.micro"
 subnet_id = "${var.target_subnet_id}"

 tags {
  Name = "${var.env_prefix}-frontend-app-instance"
  Environment = "${var.env_prefix}"
 }
}
