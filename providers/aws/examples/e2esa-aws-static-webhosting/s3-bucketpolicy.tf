# resource "aws_s3_bucket_policy" "this" {
#   bucket = var.s3_bucket_name

#   policy = <<POLICY
# {
#     "Version": "2008-10-17",
#     "Id": "PolicyForCloudFrontPrivateContent",
#     "Statement": [
#         {
#             "Sid": "1",
#             "Effect": "Allow",
#             "Principal": {
#                 "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${module.cloudfront.id}"
#             },
#             "Action": "s3:GetObject",
#             "Resource": "arn:aws:s3:::${data.aws_s3_bucket.selected.id}/*"
#         }
#     ]
# }
# POLICY
# depends_on = [
#   module.cloudfront
# ]
# }
