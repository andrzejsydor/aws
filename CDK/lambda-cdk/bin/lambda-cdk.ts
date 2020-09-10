#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from '@aws-cdk/core';
import { LambdaCdkStack } from '../lib/lambda-cdk-stack';
import apigateway = require('@aws-cdk/aws-apigateway');
import lambda = require('@aws-cdk/aws-lambda');


export class ApiLambdaStack extends cdk.Stack {
    constructor(app: cdk.App, id: string, env={'region':'us-east-1'}) {
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

    }

}

const app = new cdk.App();
new ApiLambdaStack(app, 'ApiLambda');
app.synth();
