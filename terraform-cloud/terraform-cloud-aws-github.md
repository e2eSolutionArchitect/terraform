
## Guide to configuring Terraform Cloud pipeline using GuitHub Actions for AWS resource deployment 

## Pre-requisites:

**AWS OIDC Role**
- Please refer [here](https://github.com/TheSolutionArchitect/terraform/blob/main/terraform-cloud/oidc-aws-iam-role.md) for OIDC role creation.

**Terraform Cloud Configuration**
- Create Terraform Cloud Organization
- Create Terraform Cloud Project
- Create Terraform Cloud Workspace
- Update the Terraform provider file in code with the organization and workspace name. like below.
- 
```
terraform {
  cloud {
    organization = "e2esolutionarchitect"

    workspaces {
      name = "tf-aws-template-infra-core"
    }
  }
}
```
- Create Terraform Cloud Token (To be added to TF_API_TOKEN in GitHub secret)
  NOTE: No variables or secrets to be added in Terraform Cloud Configuration
  

**GitHub Configuration**

GitHub Variables:
|   |   |   |
|---|---|---|
|TF_API_TOKEN | Token created from Terraform Cloud portal | <token value> |
|AWS_ROLE_ARN | the oidc role |arn:aws:iam::############:role/e2esa-aws-terraform-github-oidc |
|AWS_REGION | AWS Region | e.g., us-east-1 |

## Developer's system: VSC Code

Terraform code reference

provider.tf

```
terraform {
  required_version = "~> 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}


provider "aws" {
  #profile = "demo"
  region  = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  token = var.token
}

terraform {
  cloud {
    organization = "e2esolutionarchitect"

    workspaces {
      name = "tf-aws-template-infra-core"
    }
  }
}
```

variables.tf

```
variable "aws_region" {
    type = string
}

variable "secret_key" {
  type = string
  sensitive = true
}
variable "access_key" {
  type = string
  sensitive = true
}
variable "token" {
  type = string
  sensitive = true
}

and other required variables.

```
app.auto.tfvars : should contain the tf values. 

## GitHub Action Pipeline

```
name: "TF Deploy4"

on:
  workflow_dispatch:
  # push:
  #   branches:
  #     - main
permissions:
  id-token: write   # This is required for requesting the JWT
  contents: read 
jobs:
  terraform:
    name: "Terraform"
    runs-on: ubuntu-latest
    env:	
      AWS_REGION: 'us-east-1'

    steps:
      - name: Checkout
        uses: actions/checkout@v4.2.2

      - name: configure aws credentials
        uses: aws-actions/configure-aws-credentials@v4.0.2
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          role-session-name: tfsession
          aws-region: ${{ secrets.AWS_REGION }}

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3.1.2
        with:
          cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }}

      - name: Terraform Init
        id: init
        run: |
            pwd
            echo -e "access_key = \"${AWS_ACCESS_KEY_ID}\"\nsecret_key = \"${AWS_SECRET_ACCESS_KEY}\"\ntoken = \"${AWS_SESSION_TOKEN}\"\naws_region = \"${AWS_REGION:-${AWS_DEFAULT_REGION}}\"" | tee credentials.auto.tfvars
            terraform init

      - name: Terraform Plan
        id: plan
        #if: github.event_name == 'push'
        run: |
            pwd
            ls
            terraform plan
        continue-on-error: true

      - name: Terraform Plan Status
        if: steps.plan.outcome == 'failure'
        run: exit 1

      - name: Terraform Apply
        #if: github.ref == 'refs/heads/main' && github.event_name == 'push'
        run: terraform apply -auto-approve
```

-------

```
terraform login
```
- Create Terraform Cloud Token 
- Enter the token in the terraform console prompt
- terraform cloud should be connected

```
terraform init 
```

## ATTENTION REQUIRED:
The below line of code in pipeline plays a vital role. 
```
echo -e "access_key = \"${AWS_ACCESS_KEY_ID}\"\nsecret_key = \"${AWS_SECRET_ACCESS_KEY}\"\ntoken = \"${AWS_SESSION_TOKEN}\"\naws_region = \"${AWS_REGION:-${AWS_DEFAULT_REGION}}\"" | tee credentials.auto.tfvars
```

The AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN, AWS_DEFAULT_REGION are populated from below part of code or OIDC role call.

```
      - name: configure aws credentials
        uses: aws-actions/configure-aws-credentials@v4.0.2
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          role-session-name: tfsession
          aws-region: ${{ secrets.AWS_REGION }}
```

"tee credentials.auto.tfvars" part of code sets the values to the variables in 'credentials.auto.tfvars'. credentials.auto.tfvars is a reserved terraform tfvar file used to set credentials. The developer doesn't need to create it. above line of code creates it runtime. 
and access_key, secret_key, token, aws_region are defined in variables.tf but are set in above line of code by OIDC role. 
These are used in providers.tf file for AWS provider connection like below.

```
provider "aws" {
  region  = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  token = var.token
}
```

# Terraform Cloud Configuration steps with screenshots

**Create Terraform Cloud Token**

<img width="1916" alt="image" src="https://github.com/user-attachments/assets/26a82825-e959-451d-94fb-54efee026878" />

**Create Project**

<img width="1919" alt="image" src="https://github.com/user-attachments/assets/b1303c45-297e-4962-a18c-6636d1e48b00" />

**Create Workspace**

<img width="1918" alt="image" src="https://github.com/user-attachments/assets/d1758393-736e-497a-9e06-bf71e977477f" />

<img width="1915" alt="image" src="https://github.com/user-attachments/assets/ac252fb6-ad60-48ad-ba7d-30a623e61f72" />

<img width="1906" alt="image" src="https://github.com/user-attachments/assets/ae564d6c-aa93-4f74-8352-584f24bcc43b" />

<img width="1906" alt="image" src="https://github.com/user-attachments/assets/f23de3c0-c707-4520-a05e-89b67ffda101" />


<img width="1918" alt="image" src="https://github.com/user-attachments/assets/1ad0a62b-e1a0-4545-8077-db4929e31274" />

<img width="1916" alt="image" src="https://github.com/user-attachments/assets/0c4ea1b3-ce7c-4f7d-add4-1f35e0556420" />

<img width="1916" alt="image" src="https://github.com/user-attachments/assets/a8580f45-87fc-4156-ab06-2994c40d5566" />

<img width="1916" alt="image" src="https://github.com/user-attachments/assets/23f2a677-d23b-4599-87ed-2bcceff94783" />

**Update Organization and Workspace in Terraform code**
<img width="1915" alt="image" src="https://github.com/user-attachments/assets/2adc57aa-90fc-4694-9e6a-b69767fa6d5f" />

- Push all changes to git repo
- Go to Actions and initiate the TF Deploy pipeline
- Check the progress in TFC portal and in Git Pipeline portal
- Refer [here](https://github.com/TheSolutionArchitect/tf-aws-template-infra-core/actions) for actual pipeline reference. 
