data "aws_iam_policy_document" "bucket_policy_document" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.host.bucket}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.host.id
  policy = data.aws_iam_policy_document.bucket_policy_document.json
}
