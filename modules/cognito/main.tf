
resource "aws_cognito_user_pool" "this" {
  name = "${var.project}-user-pool"
}

resource "aws_cognito_user_pool_client" "this" {
  name         = "${var.project}-client"
  user_pool_id = aws_cognito_user_pool.this.id

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  allowed_oauth_flows = ["code"]
  allowed_oauth_scopes = ["openid", "email"]
  allowed_oauth_flows_user_pool_client = true
  supported_identity_providers = ["COGNITO"]

    callback_urls = [
    "http://localhost:8080/login/oauth2/code/cognito"
  ]

  logout_urls = [
    "http://localhost:8080"
  ]

    access_token_validity  = 60
    id_token_validity      = 60
    refresh_token_validity = 30
    token_validity_units {
      access_token  = "minutes"
      id_token      = "minutes"
      refresh_token = "days"
    }

  prevent_user_existence_errors = "ENABLED"

  depends_on = [aws_cognito_user_pool.this]
}

resource "aws_cognito_user_group" "user_group" {
  name         = "USER"
  user_pool_id = aws_cognito_user_pool.this.id
  description  = "Grupo de usuários padrão"
  precedence   = 1
}


resource "aws_cognito_user_group" "admin_group" {
  name         = "ADMIN"
  user_pool_id = aws_cognito_user_pool.this.id
  description  = "Grupo de administradores"
  precedence   = 0
}

variable "project" {}

output "user_pool_id" {
  value = aws_cognito_user_pool.this.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.this.id
}

output "user_group_name" {
  value = aws_cognito_user_group.user_group.name
}

output "admin_group_name" {
  value = aws_cognito_user_group.admin_group.name
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = "${var.project}"
  user_pool_id = aws_cognito_user_pool.this.id
}