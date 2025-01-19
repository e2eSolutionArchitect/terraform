
Reference role: arn:aws:iam::306442480424:role/e2esa-aws-terraform-github-oidc

- Create an identity provider for OIDC provider 'token.actions.githubusercontent.com'
      - Go to IAM > Identity Provider > Add provider
        - Provider name: token.actions.githubusercontent.com
        - Click add provider

- Create Trust Relationship
  - IAM > Role > Create Role
    - Trusted Identity Type: Web Identity
    - Select Web Identity from the drop-down:  'token.actions.githubusercontent.com'
    - Audience: sts.amazonaws.com
    - Github organization: either specify org or enter '*'
    - Github repository: either specify repo or enter '*'
    - Github branch: either specify branch or enter '*'
   
Copy the Role ARN and add it to AWS_ROLE_ARN in GitHub secret for GitActions Pipeline. 

## Trust Relationship

```
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
                    "token.actions.githubusercontent.com:sub": "repo:*",
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
```

## Permissions

- **e2esa-github-oidc-terraform-aws-resource-access**

This permission allows action to specific services. as it has s3,ec2,dynamodb,ssm below
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "ec2:*",
                "dynamodb:*",
                "ssm:*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```
- e2esa-github-oidc-terraform-aws-tfstates-access
  
"e2esa-aws-terraform-github-oidc" above is s3 bucket to store tfstate
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::e2esa-aws-terraform-github-oidc/*",
                "arn:aws:s3:::e2esa-aws-terraform-github-oidc"
            ]
        }
    ]
}
```

