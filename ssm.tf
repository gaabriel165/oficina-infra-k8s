resource "random_password" "jwt_secret" {
  length  = 48
  special = false
}

resource "random_password" "internal_api_secret" {
  length  = 32
  special = false
}

resource "aws_ssm_parameter" "jwt_secret" {
  name        = "/${var.project_name}/jwt_secret"
  description = "HS256 signing key shared by the microservices and the authentication Lambda"
  type        = "SecureString"
  value       = random_password.jwt_secret.result
}

resource "aws_ssm_parameter" "internal_api_secret" {
  name        = "/${var.project_name}/internal_api_secret"
  description = "Shared secret the authentication Lambda sends to the internal routes of the service order microservice"
  type        = "SecureString"
  value       = random_password.internal_api_secret.result
}
