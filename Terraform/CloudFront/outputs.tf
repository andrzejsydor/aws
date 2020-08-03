output "domain_name" {
  value = aws_cloudfront_distribution.cloudfront_distribution.origin
}
