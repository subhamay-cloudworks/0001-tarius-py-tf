## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition                  - CloudWatch Alarm Module
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
######################################## Lambda Function  ##########################################
variable "lambda_function_base_name" {
  description = "The base name of the lambda function"
  type        = string
  default     = "lambda-function-name"
}
######################################## CloudWatch Alarm ##########################################
variable "cloudwatch_alarm_namespace" {
  description = "The CloudWatch Alarm namespace"
  type        = string
  default     = "AWS/Lambda"
}

variable "cloudwatch_alarm_statistics" {
  description = "The CloudWatch Alarm statistics"
  type        = string
  default     = "Average"
}

variable "cloudwatch_metric_name" {
  description = "The CloudWatch Alarm metric name"
  type        = string
  default     = "Duration"
}

variable "cloudwatch_alarm_period" {
  description = "The CloudWatch Alarm period in seconds"
  type        = number
  default     = 900
}

variable "cloudwatch_alarm_evaluation_period" {
  description = "The CloudWatch Alarm evaluation period"
  type        = number
  default     = 2
}

variable "cloudwatch_alarm_comparison_operator" {
  description = "The CloudWatch Alarm comparison operator"
  type        = string
  default     = 2
}

variable "cloudwatch_alarm_threshold" {
  description = "The CloudWatch Alarm threshold"
  type        = number
  default     = 10
}

variable "cloudwatch_alarm_description" {
  description = "The CloudWatch Alarm description"
  type        = string
  default     = ""
}

variable "datapoints_to_alarm" {
  description = "The CloudWatch Alarm datapoints to alarm"
  type        = number
  default     = 1
}
######################################## SNS Topic #################################################
variable "sns_topic_arn" {
  description = "The arn of the SNS Topic"
  type        = string
  default     = "arn:aws:sns:us-east-1:111111111111:sns-topic-name"
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
  cloudwatch_alarm_name = "${var.lambda_function_base_name}-${lower(var.cloudwatch_metric_name)}-alarm-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  lambda_function_name = "${var.lambda_function_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}
