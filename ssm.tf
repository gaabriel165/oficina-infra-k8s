resource "random_password" "jwt_secret" {
  length  = 48
  special = false
}

resource "random_password" "webhook_secret" {
  length  = 32
  special = false
}

resource "aws_ssm_parameter" "jwt_secret" {
  name        = "/${var.project_name}/jwt_secret"
  description = "HS256 signing key shared by the API and the authentication Lambda"
  type        = "SecureString"
  value       = random_password.jwt_secret.result
}

resource "aws_ssm_parameter" "webhook_secret" {
  name        = "/${var.project_name}/webhook_secret"
  description = "Shared secret expected on the budget approval webhook"
  type        = "SecureString"
  value       = random_password.webhook_secret.result
}
