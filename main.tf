resource "aws_s3_bucket" "b" {
  bucket = "jmartinson-asdf-bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
