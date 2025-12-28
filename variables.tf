variable "aws_region" {
  type    = string
  default = "ap-northeast-2"
}

# -- db
variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

# -- secret
variable "secret_key" {
  type      = string
  sensitive = true
}

variable "github_client_id" {
  type = string
}

variable "github_client_secret" {
  type      = string
  sensitive = true
}