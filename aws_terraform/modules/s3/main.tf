resource "aws_s3_bucket" "tfstate_storage" {
  bucket  = "tfstate-isseeeeeeeey-com"
  acl     = "private"

  versioning {
    enabled = true
  }
}