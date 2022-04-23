resource "aws_dynamodb_table" "this" {
  name         = var.db_table_name
  billing_mode = var.billing_mode #"PROVISIONED"
  hash_key     = var.hash_key     #"LockId"
  attribute {
    name = var.attr_name #"LockId"
    type = var.attr_type #"S"
  }
  tags = merge({ "ResourceName" = var.db_table_name }, var.tags)
}