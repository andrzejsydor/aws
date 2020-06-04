# https://www.terraform.io/docs/providers/aws/r/ssm_parameter.html

resource "aws_ssm_parameter" "secret" {
  name        = "/${var.environment}/${var.secret_string_name}"
  type        = "SecureString"
  value       = "${var.secret_string}"
}
