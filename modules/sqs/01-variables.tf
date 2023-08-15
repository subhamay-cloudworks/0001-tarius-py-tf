## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition                  - SQS Module
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
######################################## SQS Queue #################################################
variable "sqs_queue_base_name" {
  description = "The base name of the SQS Queue"
  type        = string
}
variable "delay_seconds" {
  description = "SQS queue delay seconds"
  type        = number
}
variable "max_message_size" {
  description = "SQS queue maximum message size"
  type        = number
}
variable "message_retention_seconds" {
  description = "SQS queue message retention period in seconds"
  type        = number
}
variable "receive_wait_time_seconds" {
  description = "SQS queue receive wait time in seconds"
  type        = number
}
######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  queue_name = "${var.project_name}-${var.sqs_queue_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}