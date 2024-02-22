module "aws_lb" {
  source = "../../modules/e2esa-module-aws-elb"
  tags   = merge({ "resourcename" = "${local.name}-backup-plan-${var.suffix}" }, local.tags)
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}