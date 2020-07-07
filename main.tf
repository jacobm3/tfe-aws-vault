resource "aws_s3_bucket" "b" {
  bucket = "jmartinson-asdf-bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# resource "aws_s3_bucket" "b2" {
#   bucket = "jmartinson-asdf-bucket2"
#   acl    = "private"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }

