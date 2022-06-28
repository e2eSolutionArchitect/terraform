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
checkov --directory $PWD # incase you are already into the tf code directory
```

```
checkov --file /path/to/file/example.tf
checkov -f /path/to/file/example1.yml -f /path/to/file/example2.yml
```
