resource "aws_s3_bucket" "example" {
  bucket = "my-unique-bucket-name-2027-20072026"

  tags = {
    Name        = "My Bucket"
    Environment = "Dev"
  }
}
