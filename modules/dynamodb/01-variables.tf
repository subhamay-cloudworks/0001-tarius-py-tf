## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition                  - DynamoDB Module
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
  description = "KMS Key Id"
  type        = string
}
######################################## DynamoDB Table ############################################
variable "dynamodb_table_base_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "partition_key" {
  description = "The partition key or hash key of the dynamodb table."
  type        = string
}

variable "partition_key_data_type" {
  description = "The partition key or hash key datat type of the dynamodb table."
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
  dynamodb_table_name = "${var.project_name}-${var.dynamodb_table_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}