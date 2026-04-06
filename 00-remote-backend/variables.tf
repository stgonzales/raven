variable "default_tags" {
    type = object({
        Project = string
        Environment = string
    })

    default = {
        Project = "Raven"
        Environment = "production"
    }
}

variable "aws_role" {
  type = object({
    arn     = string
    region  = string
  })
  description = "The AWS role to use for Terraform"

  default = {
    arn     = "arn:aws:iam::946614780735:role/Raven-Terraform-Role"
    region  = "us-east-1"
  }
}

variable "remote_backend" {
  type = object({
    bucket_name = string
  })
  description = "The remote backend to use for Terraform state"

  default = {
    bucket_name = "raven-terraform-state-bucket-946614780735"
  }
}

resource "random_string" "this" {
  length  = 8
  special = true
}