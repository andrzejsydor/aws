# https://www.terraform.io/docs/providers/aws/r/ssm_parameter.html

resource "aws_ssm_parameter" "secret" {
  name        = "/${var.environment}/password/master"
  description = "The parameter description"
  type        = "SecureString"
  value       = "${var.secret_password}"
}
