variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "s3_bucket_logs" {
  default = "s3-bucket-logs-345345dfshtjylk43298"
}

variable "s3_bucket_results" {
  default = "s3-bucket-results-345345dfshtjylk43298"
}
