# https://www.terraform.io/docs/providers/aws/r/lambda_function.html

data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "put.py"
    output_path   = "lambda_function_payload.zip"
}

# Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_put_dynamodb.function_name}"
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.accountId}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
}

resource "aws_lambda_function" "lambda_put_dynamodb" {
  function_name = var.lambda_function_name
  filename      = "lambda_function_payload.zip"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "put.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = "${base64sha256("lambda_function_payload.zip")}"

  runtime = "python3.8"

  tags = {
    Project        = var.TAG-Project
    Environment    = var.TAG-Environment
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_logs, aws_cloudwatch_log_group.lambda_log_group]
}
