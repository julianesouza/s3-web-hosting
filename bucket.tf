resource "aws_s3_bucket" "host" {
  bucket = "static-website-host-170401"

  tags = {
    Name        = "Static Website Host"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "host_configs" {
  bucket = aws_s3_bucket.host.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "host_controls" {
  bucket = aws_s3_bucket.host.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "host_blocks" {
  bucket = aws_s3_bucket.host.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "host_acls" {
  depends_on = [
    aws_s3_bucket_ownership_controls.host_controls,
    aws_s3_bucket_public_access_block.host_blocks,
  ]

  bucket = aws_s3_bucket.host.id
  acl    = "public-read"
}
