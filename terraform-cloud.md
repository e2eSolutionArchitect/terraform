
## Instruction to configure Terraform project for Terraform Cloud 

- Using CLI for terraform apply 
```
terraform login
```
- Create token 
- Enter token in terraform console prompt
- teraform cloud should be connected

```
terraform init 
terraform apply
```

- It should start the plan in terraform cloud portal workspace 

Please make sure the following configuration in Terraform Cloud
- A Service  Principal has been created and added as environment variables (HCP_CLIENT_ID, HCP_CLIENT_SECRET) in Terraform Cloud in particular workspace under variables.
- Azure connection credentials added  as environment variables (ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID, ARM_SUBSCRIPTION_ID) in Terraform Cloud in that particular workspace under variables.
- Note: ARM_ for Azure variables. for AWS and GCP please add the respective variables same way
