
# How to execute
# Step 1 : terraform init
# Step 2: terraform validate
# Setp 3: terraform plan -var-file="app.tfvars" -var="createdBy=e2esa"
# Setp 4: terraform apply -var-file="app.tfvars" -var="createdBy=e2esa"
# Setp 5: terraform destroy -var-file="app.tfvars" -var="createdBy=e2esa"