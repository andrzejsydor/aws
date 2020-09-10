const AWS = require('aws-sdk');

export const handler = async (): Promise<any> => {

    return { statusCode: 200, body: JSON.stringify("Hello world") };

};
