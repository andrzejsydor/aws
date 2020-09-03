variable "lambda_function_name" {
  default = "lambda_Java11_function_with_X-Ray"
}

resource "aws_lambda_function" "aws_lambda_xray" {
  function_name = var.lambda_function_name
  filename      = "lambdafunction/target/lambdafunction-1.0.jar"
  role          = aws_iam_role.iam_for_lambda.arn
  # lambda handler function name, it will be full class path name with package name
  handler       = "com.example.awslambda.AppHandler"

  # # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  # source_code_hash = base64sha256("lambda_function_payload.zip")

  runtime = "java11"

  tracing_config {
    mode = "Active"
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_logs, aws_cloudwatch_log_group.lambda_log_group]
}
