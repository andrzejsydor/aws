resource "aws_instance" "aws_instance_sessions_manager" {
  ami             = var.ami
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = [aws_security_group.bastion.name]
  iam_instance_profile = "EC2_adm"
  count = "1"

  user_data = <<-EOT
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y https://s3.us-east-1.amazonaws.com/amazon-ssm-region/latest/linux_amd64/amazon-ssm-agent.rpm
  EOT
}

resource "aws_s3_bucket" "aws_s3_bucket_sessions_manager" {
  bucket = "aws-s3-bucket-sessions-manager-987432kjfdhr3928yf9ew"
  acl    = "private"
}

resource "aws_iam_policy" "sessions_manager_permissions" {
  name        = "sessions_manager_permissions"
  path        = "/"
  description = "IAM policy for Sessions Manager"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:UpdateInstanceInformation",
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::aws_s3_bucket_sessions_manager/s3-bucket-prefix-sessions-manager"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetEncryptionConfiguration"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt"
            ],
            "Resource": "arn:aws:kms:us-east-1:926633787768:key/314c0789-360b-47d7-abb4-149d8dbbcc98"
        }
    ]
}
EOF
}

resource "aws_iam_role" "aws_iam_role_sesssions_manager" {
  name = "aws_iam_role_sesssions_manager"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment_sessions_manager" {
  role       = aws_iam_role.aws_iam_role_sesssions_manager.name
  policy_arn = aws_iam_policy.sessions_manager_permissions.arn
}

resource "aws_iam_instance_profile" "aws_iam_instance_profile_sessions_manager" {
  name = "aws_iam_instance_profile_sessions_manager"
  role = aws_iam_role.aws_iam_role_sesssions_manager.name
}
