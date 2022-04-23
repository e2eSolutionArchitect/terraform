## 'End To End Solution Architect' forum brings to you the terraform scripts for infrastructure provisioning in AWS, Azure and Google Cloud Platform
Terraform for AWS, Azure, GCP

### For Terraform professional consultancy and Technology advisory please feel free to drop a note to som@e2eSolutionArchitect.com
[Click here](https://e2esolutionarchitect.com/tag/terraform) for Terraform advance articles

e2eSA Solutions for Terraform
- Initialize Terraform offline in Windows, Ubuntu [Click here](https://github.com/e2eSolutionArchitect/terraform/blob/main/providers/docs/terraform-offline-initialize.md)

#### How to execute
- Step 1 : terraform init
- Step 2: terraform validate
- Setp 3: terraform plan -var-file="app.tfvars" -var="createdBy=e2esa"
- Setp 4: terraform apply -var-file="app.tfvars" -var="createdBy=e2esa"
- Setp 5: terraform destroy -var-file="app.tfvars" -var="createdBy=e2esa"

### Examples (AWS)
- Setup Terraform backend/state management with AWS S3 [Click here ](https://github.com/e2eSolutionArchitect/terraform/tree/main/providers/aws/examples/e2esa-aws-s3backend).

### Terraform Modules (AWS)
- AWS S3 [Click here](https://github.com/e2eSolutionArchitect/terraform/tree/main/providers/aws/modules/e2esa-aws-s3).
- DynamoDB [Click here](https://github.com/e2eSolutionArchitect/terraform/tree/main/providers/aws/modules/e2esa-aws-dynamodb).
