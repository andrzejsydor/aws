const core = require('@aws-cdk/core');
const s3 = require('@aws-cdk/aws-s3');

class HelloCdkStack extends core.Stack {
  constructor(scope, id, props) {
    super(scope, id, props);

    new s3.Bucket(this, 'MyFirstBucket', {
      versioned: true,
      encryption: s3.BucketEncryption.KMS_MANAGED
    });
  }
}

module.exports = { HelloCdkStack }
