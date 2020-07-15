import json
from pprint import pprint
import boto3

def put(guid, region, dynamodb=None):
    if not dynamodb:
        dynamodb = boto3.resource('dynamodb')

    table = dynamodb.Table('guids')
    response = table.put_item(
       Item={
            'guid': guid,
            'region': region,
            'info': {
                'plot': 'plot',
                'rating': 'rating2'
            }
        }
    )
    return response

def lambda_handler(event, context):
        
    queryStringParameters = event["queryStringParameters"]
    key = queryStringParameters["key"]
    print(key)
    value = queryStringParameters["value"]
    print(value)

    response = put(key, value);

    pprint(response)
    
    return {
        'statusCode': 200,
        'body': json.dumps('Succesfully added to DynamoDB!')
    }
