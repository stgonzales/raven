terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket       = "raven-terraform-state-bucket-946614780735"
    key          = "networking/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
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