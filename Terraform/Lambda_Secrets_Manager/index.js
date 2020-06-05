var AWS = require('aws-sdk'),
    region = "us-east-1",
    secretName = "a",
    secret,
    decodedBinarySecret;

var client = new AWS.SecretsManager({ 
    region: 'us-east-1'
});

async function mySecrets(secretName) {

    return new Promise((resolve,reject)=>{
        client.getSecretValue({SecretId: secretName}, function(err, data) {

            // In this sample we only handle the specific exceptions for the 'GetSecretValue' API.
            // See https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_GetSecretValue.html
            // We rethrow the exception by default.
            if (err) {
                reject(err);
            }
            else {
                // Decrypts secret using the associated KMS CMK.
                // Depending on whether the secret is a string or binary, one of these fields will be populated.
                if ('SecretString' in data) {
                    resolve(data.SecretString);
                } else {
                    let buff = new Buffer(data.SecretBinary, 'base64');
                    resolve(buff.toString('ascii'));
                }
            }
        });
    });
}

exports.handler = async (event) => {

    var key = event['key'];
    var value = await mySecrets(key);
    
    const response = {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda!'),
        key: value
    };
    return response;
};
