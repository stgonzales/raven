variable "default_tags" {
  type = object({
    Project     = string
    Environment = string
  })

  default = {
    Project     = "Raven"
    Environment = "production"
  }
}

variable "aws_role" {
  type = object({
    arn    = string
    region = string
  })
  description = "The AWS role to use for Terraform"

  default = {
    arn    = "arn:aws:iam::946614780735:role/Raven-Terraform-Role"
    region = "us-east-1"
  }
}

variable "eks_cluster" {
  type = object({
    name                 = string
    role_name            = string
    node_group_name      = string
    node_group_role_name = string
  })
  description = "The EKS cluster configuration"

  default = {
    name                 = "raven-eks-cluster"
    role_name            = "raven-eks-cluster-role"
    node_group_name      = "raven-eks-node-group"
    node_group_role_name = "raven-eks-node-group-role"
  }
}

variable "ecr_repositories" {
  type = list(object({
    name                 = string
    image_tag_mutability = string
    force_delete         = bool
  }))
  description = "The ECR repositories configuration"

  default = [
    {
      name                 = "raven-ecr-repository/production/backend"
      image_tag_mutability = "MUTABLE"
      force_delete         = true
    },
    {
      name                 = "raven-ecr-repository/production/frontend"
      image_tag_mutability = "MUTABLE"
      force_delete         = true
    },
  ]
}