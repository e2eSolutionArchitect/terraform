
# Define a map and use

Please [check here](../providers/aws/projects/e2esa-aws-lambda/)
Purpose is to create multiple resources using diff set of input params
```
variable "lambda_map" {
  type = map(object({
    lambda_function_zip_filename = string
    lambda_function_name = string
    lambda_role_arn = string
    lambda_handler = string
    lambda_runtime = string
    lambda_alias_name = string
    lambda_func_current_version = string
    lambda_func_target_version = string
  }))
}
```

TFVARS

```
lambda_map = {
    "lambda1" = {
        lambda_function_zip_filename         = "index.zip"
        lambda_function_name        = "lambda-test-01"
        lambda_role_arn             = ""
        lambda_handler              = "index.handler"
        lambda_runtime              = "nodejs14.x"
        lambda_alias_name           = "latest"
        lambda_func_current_version = "4"
        lambda_func_target_version  = "5"
    },
    "lambda2" = {
        lambda_function_zip_filename         = "index.zip"
        lambda_function_name        = "lambda-test-02"
        lambda_role_arn             = ""
        lambda_handler              = "index.handler"
        lambda_runtime              = "nodejs14.x"
        lambda_alias_name           = "latest"
        lambda_func_current_version = "4"
        lambda_func_target_version  = "5"
    }
}

```
Invoke Module

```
module "aws_lambda" {
  source               = "../../modules/e2esa-module-aws-lambda"
  for_each = var.lambda_map
  lambda_filename_zip  = each.value.lambda_function_zip_filename
  lambda_function_name = each.value.lambda_function_name
  lambda_role_arn      = each.value.lambda_role_arn
  lambda_handler       = each.value.lambda_handler
  lambda_runtime       = each.value.lambda_runtime
  tags                 = local.tags
}
```
