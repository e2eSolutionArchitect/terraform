
## Consider two Accounts Development and Production. We want to run Terraform from Development account to provision resources in Production without any aws credentials. That's why an IAM instance profile needs to be attached to the Development EC2.
Here Development EC@ is our "Build Server"

### Step 1: in PRODUCTION
- Create a Cross account ROLE in PRODUCTION account with account id of Development account. 
- Select 'Another Account' option while creating role
- Add all the required policies with this role
- role created

### Step 2: - in DEVELOPMENT 
- Create a role of EC2 type. this role will be atatched to Develoment EC2 instance as IAM profile. 
- Create a STS AssumeRole policy with this instance role

```
{
  "Version": "2012-10-17"
  "Statement": [
    "Sid":
    "Effect":
    "Action":
    "Resource": "arn:aws:iam::<PRODUCTION ACCOUNT NO>:role/<cross account role>"
  ]
}
```
### Step 3: - in DEVELOPMENT 
- Now we have the instance role added with STS assume policy.
- Attach this instance role with Development EC2 instance 
- Select the EC2 > Action > Security > Modify IAM Role

### Step 4: - in DEVELOPMENT 
- Run Terraform in Development EC2 instance. It doesn't require any aws profile or credential to pass. The attached IAM role will provide required access. 
