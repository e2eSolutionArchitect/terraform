
Configure terraform backend with AWS S3
```
terraform {
  required_version = ">= 1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
  
  backend "s3" {
    bucket         = "e2esa-tf-states"
    key            = "myproject/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "e2esa-tf-locks"
    encrypt        = true
    profile        = "default"
  }
}

# provider block

provider "aws" {
  profile = "default"
  region  = var.aws_region
}
```

If you are trying to force STS endpoint for the S3 terraform backend to specific region url. Otherwise it usually go to sts.amazonaws.com

```
terraform {
  required_version = ">= 1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
  
  backend "s3" {
    bucket         = "e2esa-tf-states"
    key            = "myproject/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "e2esa-tf-locks"
    encrypt        = true
    profile        = "default"
    # Force STS endpoint for the S3 terraform backend to specific region url. Otherwise it usually go to sts.amazonaws.com
    sts_endpoint = "https://sts.<aws-region>.amazonaws.com"
    endpoint = "https://s3.<aws-region>.amazonaws.com"
  }
}

# provider block

provider "aws" {
  profile = "default"
  region  = var.aws_region
  endpoints {
      sts = "https://sts.<aws-region>.amazonaws.com"
    s3 = "https://s3.<aws-region>.amazonaws.com"
  }
}
```
