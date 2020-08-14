resource "aws_cognito_user_pool" "pool" {
  name = "user-pool"
}

resource "aws_cognito_user_pool_client" "client" {
  name = "client"

  user_pool_id = aws_cognito_user_pool.pool.id

  callback_urls = ["http://localhost"]
}

resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name               = "identity pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.client.id
    provider_name           = "cognito-idp.us-east-1.amazonaws.com/us-east-1_1234sd"
    server_side_token_check = false
  }

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.client.id
    provider_name           = "cognito-idp.us-east-1.amazonaws.com/eu-west-1_123zxc"
    server_side_token_check = false
  }

  openid_connect_provider_arns = []
}
