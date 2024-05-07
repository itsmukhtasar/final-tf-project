resource "aws_s3_bucket" "static_website" {
  bucket = "prod-static-website-m"
  force_destroy = true  
}

resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static_website.bucket  

  index_document {
    suffix = "index.html"
  }
}




