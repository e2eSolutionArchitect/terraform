

resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_name

  tags = merge({ "ResourceName" = var.s3_bucket_name }, var.tags)
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = var.acl
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.s3_versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.this.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_kms_key" "this" {
  description             = "s3 bucket encryption key"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  # Bbucket versioning enabled first

  depends_on = [aws_s3_bucket_versioning.this]

  bucket = aws_s3_bucket.this.bucket
  count  = (var.enable_lifecycle_rule == true ? 1 : 0)
  rule {
    id = "config"

    filter {
      prefix = "config/"
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 60
      storage_class   = "GLACIER"
    }

    status = "Enabled"
  }
}
