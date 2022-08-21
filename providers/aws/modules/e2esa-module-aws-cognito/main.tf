resource "aws_cognito_user_pool" "this" {

  name                     = "${var.cognito_name}-pool"
  username_attributes      = var.username_attributes      # ["email"]
  auto_verified_attributes = var.auto_verified_attributes # ["email"]
  password_policy {
    minimum_length    = 8
    require_lowercase = false
    require_number    = true
    require_symbols   = true
    require_uppercase = true
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject_option = "Account Confirmation"
    email_message        = "Your confirmation code is {####}"
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }
  mfa_configuration          = "ON"
  sms_authentication_message = "Your code is {####}"

  sms_configuration {
    external_id    = "example"
    sns_caller_arn = aws_iam_role.example.arn
  }

  software_token_mfa_configuration {
    enabled = true
  }

  account_recovery_setting {
    post_confirmation = var.post_confirmation_lambda_arn
  }

  tags = merge(
    { "ResourceName" = var.cw_name }, var.tags
  )
}


resource "aws_cognito_user_pool_client" "this" {
  name = "${var.cognito_name}-client"

  user_pool_id = aws_cognito_user_pool.this.id
}

