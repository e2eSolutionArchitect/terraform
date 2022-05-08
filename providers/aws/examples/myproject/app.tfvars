# Common
project = "e2esa-tutorials"

# General 
aws_region = "us-east-1"

# S3
s3_bucket_names       = []
s3_bucket_name        = "e2esa-test-states"
s3_versioning         = "Enabled"
enable_lifecycle_rule = false

db_table_name = "e2esa-test-locks"
billing_mode  = "PAY_PER_REQUEST"
hash_key      = "LockID"
attr_name     = "LockID"
attr_type     = "S"