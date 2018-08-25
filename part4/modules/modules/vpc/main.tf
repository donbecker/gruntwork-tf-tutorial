

provider "aws" {
  region = "us-east-2"
}

variable "env_prefix" {
  description = "The prefix applied to resource names"
}

resource "aws_vpc" "frontendvpc" {
  cidr_block = "10.0.0.0/18"

  tags {
   Name = "${var.env_prefix}-frontend-vpc"
  }
}

resource "aws_subnet" "public-2a" {
    vpc_id = "${aws_vpc.frontendvpc.id}"
    availability_zone = "us-east-2a"
    cidr_block = "10.0.0.0/24"

    tags {
     Name = "${var.env_prefix}-frontend-vpc-public-2a"
    }
}

resource "aws_subnet" "public-2b" {
    vpc_id = "${aws_vpc.frontendvpc.id}"
    availability_zone = "us-east-2b"
    cidr_block = "10.0.1.0/24"
  
    tags {
     Name = "${var.env_prefix}-frontend-vpc-public-2b"
    }
}

resource "aws_subnet" "public-2c" {
    vpc_id = "${aws_vpc.frontendvpc.id}"
    availability_zone = "us-east-2c"
    cidr_block = "10.0.2.0/24"

    tags {
     Name = "${var.env_prefix}-frontend-vpc-public-2c"
    }
}

output "public_subnet_ids" {
  value = [
    "${aws_subnet.public-2a.id}", 
    "${aws_subnet.public-2b.id}",
    "${aws_subnet.public-2c.id}"
  ]
}
