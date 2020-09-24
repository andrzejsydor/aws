https://aws.amazon.com/blogs/security/writing-iam-policies-grant-access-to-user-specific-folders-in-an-amazon-s3-bucket/

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document

```
terraform init
terraform apply -auto-approve
terraform destroy -force -auto-approve
```

This should succeed.

`aws --profile profile-name s3 cp README.md s3://YOUR_S3_BUCKET_NAME/directory/profile-name/`

This should faild.

`aws --profile profile-name s3 cp README.md s3://YOUR_S3_BUCKET_NAME/directory/another-profile-name/`


This should succeed.

`aws --profile profile-name s3api put-object --bucket YOUR_S3_BUCKET_NAME --key developer.txt --body developer.txt --server-side-encryption "AES256"`

This should faild.

`aws --profile profile-name s3api put-object --bucket YOUR_S3_BUCKET_NAME --key developer.txt --body developer.txt`


```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Principal": "*",
            "Resource": "arn:aws:s3:::<YOUR-BUCKET-NAME-HERE>",
            "Condition": {
                "StringEquals": {
                    "aws:RequestedRegion": "us-east-1"
                },
                "DateGreaterThan": {
                    "aws:CurrentTime": "2020-06-18T00:00:00Z"
                },
                "IpAddress": {
                    "aws:SourceIp": "x.x.x.x/32"
                },
                "DateLessThan": {
                    "aws:CurrentTime": "2021-10-30T23:59:59Z"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::<YOUR-BUCKET-NAME-HERE>/directory/${aws:username}/*",
            "Condition": {
                "StringEquals": {
                    "aws:RequestedRegion": "us-east-1"
                },
                "DateGreaterThan": {
                    "aws:CurrentTime": "2020-01-01T00:00:00Z"
                },
                "IpAddress": {
                    "aws:SourceIp": "x.x.x.x/32"
                },
                "DateLessThan": {
                    "aws:CurrentTime": "2100-10-30T23:59:59Z"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::<YOUR-BUCKET-NAME-HERE>/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-server-side-encryption": "AES256"
                },
                "IpAddress": {
                    "aws:SourceIp": "x.x.x.x/32"
                }
            }
        }
    ]
}
```