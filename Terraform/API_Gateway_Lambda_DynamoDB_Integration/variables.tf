variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "TAG-Project" {
  default = "test-dynamodb-table"
}

variable "TAG-Environment" {
  default = "Sandbox"
}

variable "lambda_function_name" {
  default = "lambda_put_dynamodb"
}

variable "accountId" {
  default = ""
}
