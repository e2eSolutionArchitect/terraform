# Terraform Commands

***Validate***
```
terraform validate
```

***Plan***
```
terraform plan
terraform plan -var-file="dev.tfvars"
```

***Apply***
```
terraform apply
terraform apply -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars" -auto-approve
```

***Destroy***
```
terraform destroy
terraform destroy -var-file="dev.tfvars"
terraform destroy -var-file="dev.tfvars" -aotu-approve
```

***Target Destroy***
```
terraform destroy target=<tf_resource_id>
```

***Replace/Taint***
```
terraform apply -replace=<tf_resource_id>
```

***Update Modules***
```
terraform get 
```

***find resource list from state***
```
terraform show 
```
