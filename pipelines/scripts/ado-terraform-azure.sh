cd providers/azure/projects/e2esa-azure-rg/
terraform init
terraform validate
terraform plan -var-file="dev.tfvars" -var="createdby=som"
terraform apply -var-file="dev.tfvars" -var="createdby=som" -auto-approve
terraform destroy -var-file="dev.tfvars" -var="createdby=som" -auto-approve
