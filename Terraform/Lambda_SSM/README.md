
```
aws lambda invoke \
    --function-name lambda_function_name_SSM \
    --invocation-type Event \
    --payload '{ "name": "Bob" }' \
    response.json
```


```
aws lambda invoke --function-name lambda_function_name_SSM --invocation-type Event --payload '{ "name": "Bob" }' response.json
aws lambda invoke --function-name lambda_function_name_SSM --invocation-type Event --payload "{}" --output json response.json
```