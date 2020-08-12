DeletionPolicy: Delete,Retain,Snapshot

[https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-deletionpolicy.html](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-deletionpolicy.html)

aws cloudformation create-stack --template-body file://s3-bucket.json --stack-name s3-instance --output json

aws cloudformation create-stack --template-body file://s3-bucket.json --stack-name s3-instance --parameters ParameterKey=DeletionPolicyParameter,ParameterValue=Delete --output json

aws cloudformation delete-stack --stack-name s3-instance --output json
