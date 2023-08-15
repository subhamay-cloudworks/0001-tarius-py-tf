## ---------------------------------------------------------------------------------------------------------------------
## Output                               - Lambda Module
## Modification History:
##   - 1.0.0    May 22,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

output "lambda_function_arn" {
  value = aws_lambda_function.lambda-function.arn
}