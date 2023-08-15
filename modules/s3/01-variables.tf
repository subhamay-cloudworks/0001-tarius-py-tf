## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition                  - S3 Module
## Modification History:
##   - 1.0.0    May 22,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## Project Name ##############################################
variable "project_name" {
  description = "The name of the project"
  type        = string
}
######################################## Environment Name ##########################################
variable "environment_name" {
  type        = string
  description = <<EOT
  (Optional) The environment in which to deploy our resources to.

  Options:
  - devl : Development
  - test: Test
  - prod: Production

  Default: devl
  EOT

  validation {
    condition     = can(regex("^devl$|^test$|^prod$", var.environment_name))
    error_message = "Err: environment is not valid."
  }
}
######################################## GitHub Context Variables  #################################
variable "github_url" {
  description = "GitHub URL"
  type        = string
}
variable "github_ref" {
  description = "GitHub Ref"
  type        = string
}
variable "github_sha" {
  description = "GitHub Commit SHA"
  type        = string
}
variable "github_wf_run_number" {
  description = "GitHub WorkFlow Run Number"
  type        = string
}
######################################## KMS Key ###################################################
variable "kms_key_alias" {
  description = "KMS Key Alias"
  type        = string
}
variable "kms_key_arn" {
  description = "KMS Key Arn"
  type        = string
}
######################################## S3 Bucket #################################################
variable "s3_bucket_base_name" {
  description = "The base name of the S3 Bucket"
  type        = string
  default     = "landing-zone"
}
variable "s3_default_folder" {
  description = "The default folder to be created"
  type        = string
}
######################################## Lambda Function ###########################################
variable "lambda_function_arn" {
  description = "The arn of the lambda function used for bucket notification"
  type        = string
}
######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment       = var.environment_name
    ProjectName       = var.project_name
    GitHubURL         = var.github_url
    GitHubRef         = var.github_ref
    GitHubSHA         = var.github_sha
    GitHubWFRunNumber = var.github_wf_run_number
  })
}

locals {
  bucket_name = "${var.project_name}-${var.s3_bucket_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}