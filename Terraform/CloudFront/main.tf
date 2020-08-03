resource "aws_s3_bucket" "static_website_bucket" {
  bucket = var.s3-bucket-name
  acl    = "private"

  website {
    index_document="index.html"
    error_document="index.html"
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "static_website_bucket_object" {
  key    = "index.html"
  bucket = aws_s3_bucket.static_website_bucket.id
  source = "${path.cwd}/index.html"

  content_type = "text/html"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "sth"
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.static_website_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.static_website_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}



resource "aws_cloudfront_distribution" "cloudfront_distribution" {
    origin {
        domain_name = aws_s3_bucket.static_website_bucket.bucket_regional_domain_name
        origin_id = "S3-${aws_s3_bucket.static_website_bucket.bucket}"
 
        s3_origin_config {
          origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
        }
    }
    # By default, show index.html file
    default_root_object = "index.html"
    enabled = true

    # AWS WAF WEB ACL
    # web_acl_id = "WAF-ACL-cloud-front"

    # If there is a 404, return index.html with a HTTP 200 Response
    custom_error_response {
        error_caching_min_ttl = 3000
        error_code = 404
        response_code = 200
        response_page_path = "/index.html"
    }

    default_cache_behavior {
        allowed_methods = ["GET", "HEAD"]
        # allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = "S3-${aws_s3_bucket.static_website_bucket.bucket}"

        # Forward all query strings, cookies and headers
        forwarded_values {
            query_string = true

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "allow-all"
        min_ttl = 0
        default_ttl = 3600
        max_ttl = 86400
    }

    # Distributes content to US and Europe
    price_class = "PriceClass_100"

    # Restricts who is able to access this content
    restrictions {
        geo_restriction {
            # type of restriction, blacklist, whitelist or none
            restriction_type = "none"
        }
    }

    # SSL certificate for the service.
    viewer_certificate {
        cloudfront_default_certificate = true
    }
}
