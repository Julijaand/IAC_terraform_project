terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.20.1"
    }
  }
}
provider aws {
  region = var.region
  profile = var.profile
}

# Retrieve the default VPC for the region
data "aws_vpc" "main" {
  default = true
}

# EC2 instance resource
resource "aws_instance" "d4ml-dev-julijaand-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  iam_instance_profile = var.instance_profile
  subnet_id     = var.subnet_id
  # vpc_security_group_ids = var.vpc_security_group_ids
  tags = {
    Name = "d4ml-dev-julijaand-instance"
  }
}

# Module for Infrastructure Source code repository
module "codecommit_infrastructure_source_repo" {
  source = "./modules/codecommit"

  create_new_repo          = false
  source_repository_name   = var.source_repo_name
  source_repository_branch = var.source_repo_branch
  repo_approvers_arn       = var.repo_approvers_arn
  s3_bucket                = var.s3_bucket

  tags = {
    Project_Name = var.project_name
    Environment  = var.environment
    Account_ID   = local.account_id
    Region       = local.region
  }

}

# Module for Infrastructure Validation - CodeBuild
module "codebuild_terraform" {
  depends_on = [
    module.codecommit_infrastructure_source_repo
  ]
  source = "./modules/codebuild"

  project_name                        = var.project_name
  role_arn                            = var.existing_iam_role_arn
  s3_bucket_name                      = var.s3_bucket
  build_projects                      = var.build_projects
  build_project_source                = var.build_project_source
  builder_compute_type                = var.builder_compute_type
  builder_image                       = var.builder_image
  builder_image_pull_credentials_type = var.builder_image_pull_credentials_type
  builder_type                        = var.builder_type

  tags = {
    Project_Name = var.project_name
    Environment  = var.environment
    Account_ID   = local.account_id
    Region       = local.region
  }
}

# Module for Infrastructure Validate, Plan, Apply and Destroy - CodePipeline
module "codepipeline_terraform" {
  depends_on = [
    module.codebuild_terraform,
  ]
  source = "./modules/codepipeline"

  project_name          = var.project_name
  source_repo_name      = var.source_repo_name
  source_repo_branch    = var.source_repo_branch
  s3_bucket_name        = var.s3_bucket
  codepipeline_role_arn = var.existing_iam_role_arn
  stages                = var.stage_input

  tags = {
    Project_Name = var.project_name_pipeline
    Environment  = var.environment
    Account_ID   = local.account_id
    Region       = local.region
  }
}

