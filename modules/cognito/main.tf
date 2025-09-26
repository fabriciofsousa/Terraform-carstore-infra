resource "aws_cognito_user_pool" "this" {
  name = "${var.project}-user-pool"
}

resource "aws_cognito_user_pool_client" "this" {
  name         = "${var.project}-client"
  user_pool_id = aws_cognito_user_pool.this.id
}

variable "project" {}
output "user_pool_id" {
  value = aws_cognito_user_pool.this.id
}
