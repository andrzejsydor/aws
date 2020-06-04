variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "environment" {
  default = "dev"
}

variable "secret_password" {
  default = "secret password"
}