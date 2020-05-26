# S3 Bucket Website

```
aws s3 mb s3://mybucket --region us-west-1
aws s3 sync . s3://mybucket --acl public-read
aws s3 website s3://my-bucket/ --index-document index.html --error-document error.html
aws s3 rm s3://mybucket --recursive
aws s3 rb s3://mybucket
```

[https://docs.aws.amazon.com/cli/latest/reference/s3/mb.html](https://docs.aws.amazon.com/cli/latest/reference/s3/mb.html)

[https://docs.aws.amazon.com/cli/latest/reference/s3/rm.html](https://docs.aws.amazon.com/cli/latest/reference/s3/rm.html)

[https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html](https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html)

[https://docs.aws.amazon.com/cli/latest/reference/s3/website.html](https://docs.aws.amazon.com/cli/latest/reference/s3/website.html)
