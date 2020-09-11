import * as cdk from '@aws-cdk/core';
import apigateway = require('@aws-cdk/aws-apigateway');
import lambda = require('@aws-cdk/aws-lambda');

export class PublicApiLambdaCdkStack extends cdk.Stack {
  constructor(app: cdk.App, id: string, env = { 'region': 'us-east-1' }) {
    super(app, id);

    const lambdaFunction = new lambda.Function(this, 'lambdaFunction', {
      code: new lambda.AssetCode('src'),
      handler: 'lambdaFunction.handler',
      runtime: lambda.Runtime.NODEJS_10_X
    });

    const api = new apigateway.RestApi(this, 'lambdaApi', {
      restApiName: 'Lambda Service'
    });

    const items = api.root.addResource('lambda');
    const lambdaIntegration = new apigateway.LambdaIntegration(lambdaFunction);
    items.addMethod('GET', lambdaIntegration);

    const singleItem = items.addResource('{id}');
    const getOneIntegration = new apigateway.LambdaIntegration(lambdaFunction);
    singleItem.addMethod('GET', getOneIntegration);

  }
  
}
