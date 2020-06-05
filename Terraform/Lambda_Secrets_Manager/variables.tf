variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "environment" {
  default = "sandbox"
}

variable "lambda_function_name" {
  default = "lambda_kms"
}
