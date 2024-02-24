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
resource "myresource" "xyz"{
  # ...resource arguments..
}
module "mymodule" {
  # ...module arguments..
}
terraform destroy -target myresource.xyz
terraform destroy -target module.mymodule
```

***Replace/Taint***
```
terraform apply -replace=<tf_resource_id>
```

***Update Modules***
```
terraform get 
```

*** Find resource list from state***
```
terraform show 
```

*** Detect Configuration Drift***
```
terraform plan -refresh-only
terraform apply -refresh-only 
```

***Terraform Import***
```
# First define the resource in the .tf file
resource "aws_instance" "myvm" {
 ami           = "unknown"
 instance_type = "unknown"
}
# Now execute 
terraform import aws_instance.myvm <Instance ID>
# It update state file for myvm <Instance ID>
```

***Other Commands***
```
terraform state mv
terraform state rm  
```
