resource "aws_ecr_repository" "this" {
  name = var.project
}

variable "project" {}
output "repository_url" {
  value = aws_ecr_repository.this.repository_url
}
