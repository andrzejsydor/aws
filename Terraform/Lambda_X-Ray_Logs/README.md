
```
aws lambda invoke \
    --function-name lambda_function_name \
    --invocation-type Event \
    --payload '{ "name": "Bob" }' \
    response.json
```


```
aws lambda invoke --function-name lambda_function_name --invocation-type Event --payload '{ "name": "Bob" }' response.json
aws lambda invoke --function-name lambda_function_name --invocation-type Event --payload "{ 'name': 'Bob' }" --output json response.json
```