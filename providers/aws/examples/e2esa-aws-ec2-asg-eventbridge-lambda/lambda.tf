module "aws_lambda" {
  source               = "../../modules/e2esa-module-aws-lambda"
  lambda_filename_zip  = var.lambda_filename_zip
  lambda_function_name = var.lambda_function_name
  lambda_role_arn      = var.lambda_role_arn
  lambda_handler       = var.lambda_handler
  lambda_runtime       = var.lambda_runtime
  tags                 = local.tags
}