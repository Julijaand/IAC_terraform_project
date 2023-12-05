# Task
*Objective:* As a DevOps engineer, I want to create a {{buildspec.yml}} file for AWS CodeBuild to automate Terraform deployments, so that we can streamline our deployment process and ensure consistent infrastructure provisioning.

*Acceptance Criteria*
 * *Create an AWS CodeBuild Project*

 ** Define a CodeBuild project in AWS.
 ** Specify build environment, build commands, and artifacts.
 * *Set Up an AWS CodePipeline*

 ** Create a CodePipeline with a source stage (connecting to your code repository), a build stage (using the CodeBuild project), and a deploy stage.
 * *Configure a Deployment Target*

 ** Deploy to a simple target (e.g., S3 bucket or an EC2 instance) in the deploy stage.
 * *Trigger the Pipeline*

 ** Commit code changes to your repository and observe the automatic pipeline execution.
 * *Documentation*

 ** Document your experience and understanding of the lab.

# AWS CodePipeline CI/CD project
Terraform is an infrastructure-as-code (IaC) tool that helps you create, update, and version your infrastructure in a secure and repeatable manner.

The scope of this project is to learn how to use terraform configurations to setup validation pipelines with end-to-end tests based on AWS CodePipeline, AWS CodeBuild, AWS CodeCommit and Terraform. 

The created pipeline uses the best practices for infrastructure validation and has the below stages

- validate - This stage focuses on terraform IaC validation tools and commands such as terraform validate, terraform format, tfsec, tflint and checkov
- plan - This stage creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure.
- apply - This stage uses the plan created above to provision the infrastructure in the test account.
- destroy - This stage destroys the infrastructure created in the above stage.
Running these four stages ensures the integrity of the terraform configurations.

## Directory Structure
```shell
├── data.tf
├── locals.tf
├── main.tf
├── readme.md
├── modules
│   ├── codebuild
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── codecommit
│   │   ├── data.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── codepipeline
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf
├── templates
│   ├── buildspec_apply.yml
│   ├── buildspec_plan.yml
│   ├── buildspec_validate.yml
│   └── builspec_destroy.yml
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
├── tfplan
└── variables.tf

```
## Installation

#### Step 1: Project example template was taken from official AWS resource:

```shell
git@github.com:aws-samples/aws-codepipeline-terraform-cicd-samples.git
```
Note: If you don't have git installed, [install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).


#### Step 2: Created file `terraform.tfvars` with variables based on our requirement. 
Created such variables as: project_name, environment, source_repo_name, source_repo_branch, create_new_repo, stage_input and build_projects.

- In our case we were using an existing terraform CodeCommit repository, so the variable create_new_repo was set to false and the name of our existing repo under the variable source_repo_name was provided

#### Step 3: Created file main.tf to configure the primary resources and settings for our infrastructure 
- by main.tf resources are declared and modules called.

#### Step 4: Created Modules: Codebuild, Codecommit, Codepipeline
- Modules are used for better organization, reusability, and maintainability of infrastructure code

#### Step 5: Created file variables.tf 
- The variables.tf file in Terraform is used to define input variables for infrastructure configuration

#### Step 6: Update remote backend configuration as required

#### Step 7: Test if code is working
- In my case I have cloned it to AWS EC2 instance and tested it there

#### Step 8: Initialize the directory. Run terraform init

#### Step 8: Create a Terraform plan by running 
- terraform plan --var-file=terraform.tfvars -out=tfplan 

#### Step 9: Apply the Terraform plan by running
- terraform apply "tfplan"

#### Step 10: When test goes well, push code to project repository under personal branch

- source_repo_name   = "d4ml-iac-terraform-skillboost"
- source_repo_branch = "d4ml-iac-terraform-julija-andrusenko"
