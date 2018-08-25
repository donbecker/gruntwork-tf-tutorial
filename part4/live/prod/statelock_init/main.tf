
# creates state lock resources

provider "aws" {
  region = "us-east-2"
}

# dynamoDB for state locking
resource "aws_dynamodb_table" "gruntwork-tf-part4-prod-statelock" {
 name = "gruntwork-tf-part4-prod-statelock"
 hash_key = "LockID"
 read_capacity = 20
 write_capacity = 20

 attribute {
  name = "LockID"
  type = "S"
 }

 tags {
  Name = "gruntwork-tf-part4-prod-statelock"
 }
}

# bucket for state
resource "aws_s3_bucket" "gruntwork-tf-part4-prod-state" {
  bucket = "gruntwork-tf-part4-prod-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name = "gruntwork-tf-part4-prod-state"
  }
}
