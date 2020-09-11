const AWS = require('aws-sdk');

exports.handler = async (event: any = {}) => {
    
    console.log(`query: ${event.queryStringParameters.param1}`);
    
    console.log(`path: ${event.pathParameters.id}`);
    
    return { statusCode: 200, body: JSON.stringify(event) };
};
