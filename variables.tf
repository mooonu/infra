# -- aws
variable "aws_region" {
  type = string
}

variable "aws_account_id" {
  type = string
}

# -- ecs
variable "ecs_subnets" {
  type = list(string)
}

# -- ecr
variable "ecr_repository_url" {
  type = string
}

variable "image_tag" {
  type = string
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