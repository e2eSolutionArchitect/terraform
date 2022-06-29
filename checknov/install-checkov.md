 ## Install Checkov in Ubuntu

```
sudo apt update
sudo apt install software-properties-common
sudo apt install python3.7
sudo apt install python3-pip
sudo python3.7 -m pip install -U checkov
```
## Now its the time to run Terraform
### Make sure you have aws cli installed and configuied 
### Also terraform is installed

## Verify Checkov installation 

Just run 
```
checkov 
```

## Get sample TF code [from here](https://github.com/e2eSolutionArchitect/terraform/blob/main/checknov/checkov-tf-test.tf)
## Run checkov 

```
checkov --directory /user/path/to/iac/code
```

```
checkov --file /path/to/file/example.tf
checkov -f /path/to/file/example1.yml -f /path/to/file/example2.yml
```

## Skip docker file
```
checkov --directory /user/path/to/iac/code/.terraform --skip-check CKV_DOCKER_* -o junitxml > /user/path/to/iac/code/report.xml
```

## output to a file
```
checkov --directory /user/path/to/iac/code/.terraform -o junitxml > /user/path/to/iac/code/report.xml
```
output could be like -o { json,junitxml,cli } 
NOTE: If you get permission denied issue here then check the directory permission by 
```
ls -la
and update the permission to read write

sudo chmod 677 <directory/file>
```
