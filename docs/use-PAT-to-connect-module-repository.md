# Connect module repository from project repository

**Requirement:**
- Terraform repositories for the project and modules are in separate repositories under the same GitHub organization. 
- Both repositories are private.
- Git organization has enabled or enforced SAML SSO.
- While executing `terraform init`, it should be able to download modules from the module repository.


# Fixing SAML SSO Authentication Issue in GitHub Actions

The error occurs because your GitHub organization has SAML SSO enabled, which requires additional authentication steps. Here's how to properly fix this:

## Solution

### 1. Create a Personal Access Token (PAT) with SSO authorization
1. Go to GitHub → Settings → Developer settings → Personal access tokens
2. Create a new token with at least `repo` permissions
3. **Authorize the token for your organization**:
   - After creating the token, look for the "Configure SSO" option
   - Authorize the token for your 'myorg' organization

Please set `GH_PAT` git secrets with the PAT token created above. 

### 2. Update your GitHub Actions workflow

```yaml
- name: Configure Git for SAML SSO
  run: |
    # Configure git to use the PAT with SSO
    git config --global credential.helper store
    echo "https://${{ secrets.GH_PAT }}:@github.com" > ~/.git-credentials
    
    # Proceed with Terraform
    terraform init
```

## Important Notes

1. **Token Requirements**:
   - The PAT must have `repo` scope
   - Must be explicitly authorized for your organization via SSO
   - Consider creating a dedicated machine user for this purpose

2. **Security Best Practices**:
   - Never hardcode tokens in your repository
   - Use GitHub Secrets to store your PAT
   - Rotate tokens regularly
   - Use the principle of least privilege
