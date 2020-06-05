output "secret_simple" {
  value = aws_secretsmanager_secret_version.example_simple.secret_string
}

output "secret_map" {
  value = jsondecode(aws_secretsmanager_secret_version.secret_map.secret_string)["key1"]
}
