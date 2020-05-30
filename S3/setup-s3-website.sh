#!/bin/sh

BUCKET_NAME="mybucket123trefdfd"

aws s3 mb s3://$BUCKET_NAME --region us-east-1
aws s3 sync . s3://$BUCKET_NAME --acl public-read
aws s3 website s3://$BUCKET_NAME/ --index-document index.html --error-document error.html
