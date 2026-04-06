data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Project"
    values = [var.default_tags.Project]
  }
  filter {
    name   = "tag:Environment"
    values = [var.default_tags.Environment]
  }
  filter {
    name   = "map-public-ip-on-launch"
    values = [false]
  }
}