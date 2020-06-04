variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "lambda_function_name" {
  default = "lambda_function_name_SSM"
}

variable "environment" {
  default = "dev"
}

variable "secret_string_name" {
  default = "secret_string_name"
}
variable "secret_string" {
  default = "secret password"
}
