# https://www.terraform.io/docs/providers/aws/r/secretsmanager_secret.html
# https://www.terraform.io/docs/providers/aws/r/secretsmanager_secret_version.html

resource "aws_secretsmanager_secret" "secret_simple" {
  name                = "secret-example"
}

resource "aws_secretsmanager_secret_version" "example_simple" {
  secret_id     = aws_secretsmanager_secret.secret_simple.id
  secret_string = "secret string"
}

#################################################################################

resource "aws_secretsmanager_secret" "secret_map" {
  name                = "secret-map"
#   rotation_lambda_arn = "${aws_lambda_function.example.arn}"

#   rotation_rules {
#     automatically_after_days = 7
#   }
}

variable "example_map" {
  default = {
    key1 = "value1"
    key2 = "value2"
  }

  type = "map"
}

resource "aws_secretsmanager_secret_version" "secret_map" {
  secret_id     = aws_secretsmanager_secret.secret_map.id
  secret_string = "${jsonencode(var.example_map)}"
}
