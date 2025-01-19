

# Error
While executing Terraform pipeline in TF Cloud and using AWS OIDC role

```
│ Error: No valid credential sources found
│ 
│   with provider["registry.terraform.io/hashicorp/aws"],
│   on providers.tf line 19, in provider "aws":
│   19: provider "aws" {
│ 
│ Please see https://registry.terraform.io/providers/hashicorp/aws
│ for more information about providing credentials.
│ 
│ Error: failed to refresh cached credentials, failed to retrieve
│ credentials, operation error STS: AssumeRoleWithWebIdentity, exceeded
│ maximum number of attempts, 3, https response error StatusCode: 400,
│ RequestID: 7f67330a-9a49-4a16-9bd2-ae42a71ffae9, InvalidIdentityToken: No
│ OpenIDConnect provider found in your account for https://app.terraform.io
```

# Currently

```
# OIDC role Trust Relationship is as below
{
	"Version": "2008-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": {
				"Federated": "arn:aws:iam::306442480424:oidc-provider/token.actions.githubusercontent.com"
			},
			"Action": "sts:AssumeRoleWithWebIdentity",
			"Condition": {
				"StringLike": {
					"token.actions.githubusercontent.com:sub": "repo:*"
				}
			}
		}
	]
}
```

and provider block in terraform is as follows

```
provider "aws" {
  #profile = "demo"
  region  = var.aws_region
}

```

# Changed to 

```

```
