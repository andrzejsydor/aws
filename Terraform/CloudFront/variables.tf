variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "s3-bucket-name" {
  default = "s3-bucket-name-345345dfshtjylk43298"
}

variable "TAG-Project" {
  default = "test-dynamodb-table"
}

variable "TAG-Environment" {
  default = "Sandbox"
}
