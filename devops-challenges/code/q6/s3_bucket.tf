resource "aws_s3_bucket" "tf-test-bucket-lcrosendo" {
  bucket = "tf-test-bucket-lcrosendo"
}

resource "aws_s3_bucket_versioning" "tf-test-bucket-lcrosendo_versioning" {
  bucket = aws_s3_bucket.tf-test-bucket-lcrosendo.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "tf-test-bucket-lcrosendo_folder_uploads" {
  bucket = aws_s3_bucket.tf-test-bucket-lcrosendo.id
  key    = "uploads/" # This will simulate the folder
  #   acl    = "private"        # Optional: specify access control list
  content = "" # No content, just an empty object to represent the folder
}