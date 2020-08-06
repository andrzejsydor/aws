variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "aws_cloudwatch_event_rule_name" {
  default = "aws_cloudwatch_event_rule_name"
}

variable "retention_in_days" {
  default = 3
}
