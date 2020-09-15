resource "aws_s3_bucket" "s3_bucket_logs" {
  bucket = var.s3_bucket_logs
  force_destroy = true
  acl    = "private"
}

resource "aws_s3_bucket" "s3_bucket_results" {
  bucket = var.s3_bucket_results
  force_destroy = true
  acl    = "private"
}

resource "aws_s3_bucket_object" "s3_bucket_object_logs" {
  key    = "some.logs"
  bucket = aws_s3_bucket.s3_bucket_logs.id
  source = "${path.cwd}/some.logs"
}

resource "aws_kms_key" "kms_key" {
  deletion_window_in_days = 7
  description             = "Athena KMS Key"
}

resource "aws_athena_workgroup" "athena_workgroup_logs" {
  name = "athena_workgroup_logs"

  configuration {

    result_configuration {
      output_location = "s3://${aws_s3_bucket.s3_bucket_results.bucket}/output/"

      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = aws_kms_key.kms_key.arn
      }
    }
  }
}

resource "aws_athena_database" "athena_database_logs" {
  name   = "logs"
  bucket = aws_s3_bucket.s3_bucket_logs.id
}

resource "aws_athena_named_query" "athena_named_query_logs" {
  name      = "aws_athena_named_query"
  workgroup = aws_athena_workgroup.athena_workgroup_logs.id
  database  = aws_athena_database.athena_database_logs.name
  query     = "SELECT * FROM ${aws_athena_database.athena_database_logs.name} limit 10;"
}
