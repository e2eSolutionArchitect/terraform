resource "aws_lambda_function" "this" {

  filename         = var.lambda_filename_zip  #"lambda_function_upload.zip"
  function_name    = var.lambda_function_name #"lambda_function_name"
  role             = aws_iam_role.this.arn    #var.lambda_role_arn
  handler          = var.lambda_handler       #"index.test"
  source_code_hash = filebase64sha256("./${var.lambda_filename_zip}")
  publish          = true
  runtime          = var.lambda_runtime

  environment {
    variables = {
      FUNCTION_NAME   = var.lambda_function_name,
      ALIAS_NAME      = "VLatest",
      CURRENT_VERSION = "1",
      TARGET_VERSION  = "2"
    }
  }
  depends_on = [aws_iam_role.this]
}

resource "aws_iam_role" "this" {
  name = "iam-${var.lambda_function_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}