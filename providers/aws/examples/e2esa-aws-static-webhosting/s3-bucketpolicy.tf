resource "aws_s3_bucket_policy" "this" {
  bucket = module.aws_s3_bucket.aws_s3_bucket_id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.s3_bucket_name}/*"
            ]
        }
    ]
}
POLICY
}