#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from '@aws-cdk/core';
import { PublicApiLambdaCdkStack } from '../lib/public-api-lambda-cdk-stack';

const app = new cdk.App();
new PublicApiLambdaCdkStack(app, 'PublicApiLambdaCdkStack');
