resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3-bucket-name
  force_destroy = true
}

resource "aws_s3_bucket_policy" "s3_bucket_policy_with_grant_access_per_specific_folders" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Principal": "*",
            "Resource": "arn:aws:s3:::${var.s3-bucket-name}"
        },
        {
            "Sid": "AllowAllS3ActionsInUserFolder",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::${var.s3-bucket-name}/directory/&{aws:username}/*"
        },
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.s3-bucket-name}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-server-side-encryption": "AES256"
                }
            }
        }
    ]
}
  POLICY
}
