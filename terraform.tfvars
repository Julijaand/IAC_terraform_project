project_name       = "d4ml-dev-julijaand-project"
project_name_pipeline = "d4ml-dev-julijaand-pipeline"
environment        = "dev"
source_repo_name   = "d4ml-iac-terraform-skillboost"
source_repo_branch = "d4ml-iac-terraform-julija-andrusenko"
create_new_repo    = false
repo_approvers_arn = "arn:aws:iam::823164954914:role/role-d4ml-cloud9-deployment"
create_new_role    = false
existing_iam_role_arn = "arn:aws:iam::823164954914:role/role-d4ml-cloud9-deployment"
stage_input = [
  { name = "validate", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "SourceOutput", output_artifacts = "ValidateOutput" },
  { name = "plan", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "ValidateOutput", output_artifacts = "PlanOutput" },
  { name = "apply", category = "Build", owner = "AWS", provider = "CodeBuild", input_artifacts = "PlanOutput", output_artifacts = "ApplyOutput" },
  { name = "destroy", category = "Build", owner = "AWS", provider = "CodeBuild", input_artifacts = "ApplyOutput", output_artifacts = "DestroyOutput" }
]
build_projects = ["validate", "plan", "apply", "destroy"]

/*********************************************/
region = "eu-west-1"# All development work is done in eu-west-1 - Toms

ami_id        = "ami-053060d3af7254d90"
instance_type = "t2.micro"
instance_profile = "role-d4ml-cloud9-deployment"
key_name      = "julias_key_pair"
vpc_security_group_ids = ["JuliasSecurityGroup"]
s3_bucket = "d4ml-iac-terraform"
profile = "dev-mfa"
subnet_id = "subnet-0ce16f4e9360575be"

key_tf_backend = "build/terraform.tfstate"