data "aws_codecommit_repository" "existing_repository" {
  repository_name = var.source_repository_name
}
