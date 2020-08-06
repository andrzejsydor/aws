resource "aws_cloudwatch_event_rule" "aws_cloudwatch_event_rule_every_one_minute" {
  name                = var.aws_cloudwatch_event_rule_name
  description         = "Fires every one minutes"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_log_group" "aws_cloudwatch_log_group_schedule_test" {
  name = "/aws/events/my_group_name"
  retention_in_days = var.retention_in_days
}

resource "aws_cloudwatch_event_target" "aws_cloudwatch_event_target_every_one_minute" {
  rule      = aws_cloudwatch_event_rule.aws_cloudwatch_event_rule_every_one_minute.name
  # target_id - (Optional) The unique target assignment ID. If missing, will generate a random, unique id.
  arn = aws_cloudwatch_log_group.aws_cloudwatch_log_group_schedule_test.arn
}
