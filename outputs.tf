output "codecommit_name" {
  value       = module.codecommit_infrastructure_source_repo.repository_name
  description = "The name of the Codecommit repository"
}

output "codecommit_url" {
  value       = module.codecommit_infrastructure_source_repo.clone_url_http
  description = "The Clone URL of the Codecommit repository"
}

output "codecommit_arn" {
  value       = module.codecommit_infrastructure_source_repo.arn
  description = "The ARN of the Codecommit repository"
}

output "codebuild_name" {
  value       = module.codebuild_terraform.name
  description = "The Name of the Codebuild Project"
}

output "codebuild_arn" {
  value       = module.codebuild_terraform.arn
  description = "The ARN of the Codebuild Project"
}

output "codepipeline_name" {
  value       = module.codepipeline_terraform.name
  description = "The Name of the CodePipeline"
}

output "codepipeline_arn" {
  value       = module.codepipeline_terraform.arn
  description = "The ARN of the CodePipeline"
}

output "iam_arn" {
  value       = var.existing_iam_role_arn
  description = "The ARN of the IAM Role used by the CodePipeline"
}

