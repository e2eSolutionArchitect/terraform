Error: Inconsistent dependency when i do terraform apply from plan -out=file
```
Error: Inconsistent dependency lock file
│ 
│ The following dependency selections recorded in the lock file are
│ inconsistent with the configuration in the saved plan:
│ Terraform 0.13 and earlier allowed provider version constraints inside the
│ provider configuration block, but that is now deprecated and will be
│ removed in a future version of Terraform. To silence this warning, move the
│ provider version constraint into the required_providers block.
```

**Root Cause**
Terraform plan and apply are performed in separate machine or separate jobs in pipeline. 
The tfplan created in one machine can not be used unless terraform init is performed. 
During terraform init, it again try to access the backend configuration which might not be accessible from deployment machine.

**Solution**
ref: https://stackoverflow.com/questions/70922743/inconsistent-dependency-when-i-do-terraform-apply-from-plan-out-file

Check complete pipeline [code here](https://github.com/TheSolutionArchitect/github-actions-shared-workflows/tree/main/gh-actions-multitenant-azure)

Job1: Terraform Plan - Performed in machine 1
```
      - name: Terraform Init
        id: init
        run: |
          terraform init \
            -backend-config="resource_group_name=${{env.TF_STATE_RESOURCE_GROUP}}" \
            -backend-config="storage_account_name=${{env.TF_STATE_STORAGE_ACCOUNT_NAME}}" \
            -backend-config="subscription_id=${{env.INFRA_SUBSCRIPTION_ID}}" \
            -backend-config="tenant_id=${{env.INFRA_TENANT_ID}}"
        working-directory: ${{inputs.directory}}

      - name: Terraform Plan
        id: plan
        run: |
          terraform plan -var "deployment_tenant_id=${{env.AZURE_TENANT_ID}}" \ 
            -var "deployment_client_id=${{env.AZURE_CLIENT_ID}}" \ 
            -var "deployment_subscription_id=${{env.AZURE_SUBSCRIPTION_ID}}" \
            -var "createdby=${{ github.triggering_actor }}" \
            -var-file = "env-${{input.environment}}/terraform.tfvars" \
            -out=tfplan
```

Job2: Terraform Apply - Performed in machine 2
```

      - name: Terraform Init
        id: init
        run: |
          terraform init -backend=false # We don't need to access the backend config, as we already have tfplan. 
        working-directory: ${{inputs.directory}}

      - name: Terraform Apply
        run: |
          terraform apply -auto-approve tfplan
        working-directory: ${{inputs.directory}}

```
