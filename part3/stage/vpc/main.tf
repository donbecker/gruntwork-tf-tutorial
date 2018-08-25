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
  key = "stage/vpc/terraform.tfstate"
 }
}

resource "aws_vpc" "stage" {
  cidr_block = "10.0.0.0/18"

  tags {
   Name = "stage-vpc"
  }
}

resource "aws_subnet" "public-2a" {
    vpc_id = "${aws_vpc.stage.id}"
    availability_zone = "us-east-2a"
    cidr_block = "10.0.0.0/24"

    tags {
     Name = "stage-vpc-public-2a"
    }
}

resource "aws_subnet" "public-2b" {
    vpc_id = "${aws_vpc.stage.id}"
    availability_zone = "us-east-2b"
    cidr_block = "10.0.1.0/24"
  
    tags {
     Name = "stage-vpc-public-2b"
    }
}

resource "aws_subnet" "public-2c" {
    vpc_id = "${aws_vpc.stage.id}"
    availability_zone = "us-east-2c"
    cidr_block = "10.0.2.0/24"

    tags {
     Name = "stage-vpc-public-2c"
    }
}

output "public_subnet_ids" {
  value = [
    "${aws_subnet.public-2a.id}", 
    "${aws_subnet.public-2b.id}",
    "${aws_subnet.public-2c.id}"
  ]
}
