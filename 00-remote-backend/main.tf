terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_role.region

  default_tags {
    tags = var.default_tags
  }

  assume_role {
    role_arn = var.aws_role.arn
  }
}