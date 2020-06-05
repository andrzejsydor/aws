# https://www.terraform.io/docs/providers/aws/r/secretsmanager_secret.html
# https://www.terraform.io/docs/providers/aws/r/secretsmanager_secret_version.html

resource "aws_secretsmanager_secret" "secret_simple_for_lambda" {
  name = "secret-example-for-lambda2"
}

resource "aws_secretsmanager_secret_version" "example_simple" {
  secret_id     = aws_secretsmanager_secret.secret_simple_for_lambda.id
  secret_string = "secret string"
}
