# Instructure for OIDC roles to deploy AWS resources via GitHubActions and Terraform/Terraform Cloud 

Please refer OIDC module [here](https://github.com/e2eSolutionArchitect/terraform-aws-iam-oidc-role)


# Important:

**Role - "tf-github-aws-oidc"**: is used when using GitHub Actions & Terraform opensource to deploy resources in AWS. This role is not needed when using Terraform Cloud to perform terraform build. 

**Role - "tfc-github-aws-oidc"**: is used when using GitHub Actions & Terraform Cloud/Terraform Enterprise to deploy resources in AWS. In this case a Terrafom API token/HCP Token (generated in Terraform web portal) in configured in GitHubAction pipeline stage while doing terraform setup. refer below code

# When using Terraform Cloud/Terraform Enterprise --------------
OIDC Role like 'TFC_GH_AWS_OIDC_ROLE_ARN' should be configured in Terraform Web portal for the workspace. OIDC is not required to configured in GitHub secrects. That's why in this case 'configure aws credentials' step is not required. Please refer below code.  
```
  - name: Setup Terraform
    uses: hashicorp/setup-terraform@v3
    with:
        terraform_version: 1.10.0
        cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }} # It connect Terraform Cloud
```


# When using Terraform Opensource --------------

OIDC Role like 'TFC_GH_AWS_OIDC_ROLE_ARN' should be configured in GitHub Actions secrets. That's why in this case 'configure aws credentials' step is REQUIRED. 
Please refer below code. [click here](https://github.com/e2eSolutionArchitect/github-actions/blob/main/.github/workflows/tfc-gh-aws-plan-mock-workflow.yml) for a pipeline reference. 

```
  - name: configure aws credentials
    uses: aws-actions/configure-aws-credentials@v4
    with:
        role-to-assume: ${{ secrets.TFC_GH_AWS_OIDC_ROLE_ARN }}
        role-session-name: tfsession
        aws-region: ${{ vars.AWS_REGION }}

  - name: Setup Terraform
    uses: hashicorp/setup-terraform@v3
    with:
        terraform_version: 1.10.0
```

# While using Terraform Cloud/TF Enterprise

## 1. Please refer below code for Remote state Management in Terraform Cloud / Terraform Enterprise
```
terraform {
  cloud {
    hostname = "app.terraform.io"
    organization = "demo"
    token = null
    
    workspaces {
      name = "demo-ws-aws-ec2"
    }
  }
}
```

## 2. GitHub secrets/vars
- Terraform Cloud API Token. e.g., TFC_API_TOKEN


# While using Terraform Opensource

## 1. Please refer below code for Remote State Management 
```
  backend "s3" {
    bucket         = "tf-states"
    key            = "tfc-gh-aws-oidc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-locks"
    encrypt        = true
    profile        = "demo" # Uncomment while running from developers system. Comment when running using the pipeline
  }
```
## 2. GitHub secrets/vars
- AWS OIDC Role Arn . e.g., TF_GH_OIDC_ROLE_ARN
