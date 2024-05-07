output "static_website_dns" {
  value = "http://${aws_s3_bucket.static_website.bucket}.s3-website-${var.region}.amazonaws.com"
}



