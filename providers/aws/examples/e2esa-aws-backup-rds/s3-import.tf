# resource "aws_db_instance" "s3_import_db" {
#   s3_import {
#     source_engine         = var.engine
#     source_engine_version = var.engine_version
#     bucket_name           = var.bucket_name
#     bucket_prefix         = var.bucket_prefix
#     ingestion_role        = var.ingestion_role
#   }
# }