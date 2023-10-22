output "website_url" {
  value = "http://${aws_s3_bucket.host.bucket}.s3-website.${var.region}.amazonaws.com"
}
