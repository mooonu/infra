terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}

provider "aws" {
  region = var.aws_region
}

module "network" {
    source = "./modules/terraform-aws-network"

    project_name = "qwik-dev"
}
