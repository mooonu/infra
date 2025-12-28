# -- Parameter Store
resource "aws_ssm_parameter" "database_url" {
  name  = "/qwik/dev/DATABASE_URL"
  type  = "SecureString"
  value = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.this.endpoint}/${aws_db_instance.this.db_name}"

  tags = {
    Name = "qwik-database-url"
  }
}

resource "aws_ssm_parameter" "secret_key" {
  name  = "/qwik/dev/SECRET_KEY"
  type  = "SecureString"
  value = var.secret_key

  tags = {
    Name = "qwik-secret-key"
  }
}

resource "aws_ssm_parameter" "github_client_id" {
  name  = "/qwik/dev/GITHUB_CLIENT_ID"
  type  = "String"
  value = var.github_client_id

  tags = {
    Name = "qwik-github-client-id"
  }
}

resource "aws_ssm_parameter" "github_client_secret" {
  name  = "/qwik/dev/GITHUB_CLIENT_SECRET"
  type  = "SecureString"
  value = var.github_client_secret

  tags = {
    Name = "qwik-github-client-secret"
  }
}

resource "aws_ssm_parameter" "github_redirect_uri" {
  name  = "/qwik/dev/GITHUB_REDIRECT_URI"
  type  = "String"
  value = "https://api.qw1k.cloud/auth/callback"

  tags = {
    Name = "qwik-github-redirect-uri"
  }
}