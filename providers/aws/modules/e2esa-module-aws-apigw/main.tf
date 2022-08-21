resource "aws_api_gateway_rest_api" "this" {
  name = var.apigw_name #"example"
}

resource "aws_api_gateway_resource" "this" {
  parent_id   = var.apigw_root_resource_id
  path_part   = var.path_part
  rest_api_id = var.apigw_api_id
}

resource "aws_api_gateway_method" "this" {
  authorization    = "COGNITO_USER_POOLS"
  authorization_id = var.authorization_id
  http_method      = var.http_method #"GET"
  resource_id      = aws_api_gateway_resource.this.id
  rest_api_id      = var.apigw_api_id
  depends_on = [aws_api_gateway_resource.this
  ]
}

resource "aws_api_gateway_integration" "this" {
  http_method             = aws_api_gateway_method.this.http_method
  resource_id             = aws_api_gateway_resource.this.id
  rest_api_id             = var.apigw_api_id
  type                    = var.integration_type #"MOCK", AWS_PROXY
  uri                     = data.aws_lambda_function.lambda.invoke_arn
  integration_http_method = var.integration_http_method # POST
}

data "aws_lambda_function" "lambda" {
  function_name = var.lambda_function_name
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = var.apigw_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "this" {
  rest_api_id = var.apigw_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code
  depends_on = [aws_api_gateway_integration.this
  ]
}

# Lambda Integration

resource "aws_lambda_permission" "permission" {
  statement_id  = "AllowExecApiGWFor${var.lambda_function_name}"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.accountId}:${var.apigw_api_id}/*/${aws_api_gateway_method.this.http_method}${aws_api_gateway_resource.this.path}"
}