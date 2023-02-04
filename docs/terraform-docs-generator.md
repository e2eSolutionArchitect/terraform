## Use this great utility to generate Terraform docs automatically

[Reference](https://terraform-docs.io/user-guide/installation/)

### Step 1: Install [scoop](https://scoop.sh/) (As I'm using windows. you can use anything your choice from above reference) 

Open a PowerShell terminal (version 5.1 or later) and run:

```
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
> irm get.scoop.sh | iex
```

### Step 2: Install terraform-docs 

```
scoop bucket add terraform-docs https://github.com/terraform-docs/scoop-bucket
scoop install terraform-docs
```

### Step 3: Run terraform-docs to generate tf document
[refer](https://terraform-docs.io/user-guide/introduction/)

browse inside your terraform project directory and run below command 
```
terraform-docs markdown table .  # it will stdout the content in console
terraform-docs markdown table . > tf-spec.md # it will flush the output automatically in tf-spec.md
```

[Click here](https://github.com/e2eSolutionArchitect/terraform/blob/main/providers/aws/projects/e2esa-aws-eks-ec2/readme.md) for sample documentation generated for a project
