# https://www.terraform.io/docs/providers/aws/r/lambda_function.html

data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "index.js"
    output_path   = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  function_name = var.lambda_function_name
  filename      = "lambda_function_payload.zip"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "index.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = "${base64sha256("lambda_function_payload.zip")}"

  runtime = "nodejs12.x"

  tags = {
    Type = "Lambda"
  }

  depends_on = ["aws_iam_role_policy_attachment.lambda_logs", "aws_cloudwatch_log_group.lambda_log_group"]
}
