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

variable "vpc" {
  type = object({
    cidr_block            = string
    name                  = string
    internet_gateway_name = string
    public_subnets = list(object({
      name              = string
      cidr_block        = string
      availability_zone = string
    }))
    private_subnets = list(object({
      name              = string
      cidr_block        = string
      availability_zone = string
    }))
    public_route_table_name  = string
    private_route_table_name = string
    nat_gateway_name         = string
  })
  description = "The VPC to use for the project"

  default = {
    cidr_block            = "10.0.0.0/24"
    name                  = "raven-vpc"
    internet_gateway_name = "raven-internet-gateway"
    public_subnets = [
      {
        name              = "raven-public-subnet-us-east-1a"
        cidr_block        = "10.0.0.0/26"
        availability_zone = "us-east-1a"
      },
      {
        name              = "raven-public-subnet-us-east-1b"
        cidr_block        = "10.0.64.0/26"
        availability_zone = "us-east-1b"
      }
    ]
    private_subnets = [
      {
        name              = "raven-private-subnet-us-east-1a"
        cidr_block        = "10.0.128.0/26"
        availability_zone = "us-east-1a"
      },
      {
        name              = "raven-private-subnet-us-east-1b"
        cidr_block        = "10.0.192.0/26"
        availability_zone = "us-east-1b"
      }
    ]
    public_route_table_name  = "raven-public-route-table"
    private_route_table_name = "raven-private-route-table"
    nat_gateway_name         = "raven-nat-gateway"
  }
}