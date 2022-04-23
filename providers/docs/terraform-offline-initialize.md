Step by Step guide https://e2esolutionarchitect.com/terraform-offline-setup-and-initialization-in-windows-and-ubuntu-server/

•	Terraform OFFLINE setup and initialization in Windows and Ubuntu system (this article)
•	Terraform OFFLINE setup and initialization in Unix system on docker (coming soon)

## Initialize Terraform offline with Filesystem mirror

## Step 1: (Using PowerShell, if you are using anything else just to below instructions accordingly)
Create a directory in your file system. suppose creating "tf_cache" directory in user home ($HOME)
```
mkdir "$HOME/tf_cache"
```

Now simply copy the "registry.terraform.io" folder here. (If you are thinking where will you get it!! While you are conencted to internet. simply run terraform init. it will download .terraform in your working directory. copy "registry.terraform.io" from there and disconnect your internet to make sure below configuration is helping you to run terraform init henceforth without internet connection )

## Step 2: 
Create this file inside above directory.
For windows, Create a file "terraform.rc", if other OS then create ".terraformrc". Dont miss the '.' and the file should NOT be like "terraform.rc.txt"

## Step 3: 
Update the file terraform.rc (for Windows ) or .terraformrc (for Ubuntu) with below code block

```
provider_installation {
  filesystem_mirror {
    path    = "path/to/the/new/directory" # "c:/tf_cache"
    include = ["registry.terraform.io/hashicorp/*"]
  }
  direct {
    exclude = ["registry.terraform.io/hashicorp/*"]
  }
}

plugin_cache_dir = "path/to/the/new/directory" # "c:/tf_cache"
disable_checkpoint=true
```

## Step 4: 
Setup env variables as follows
  
  ```
for Windows
$env:TF_PLUGIN_CACHE_DIR="c:/tf_cache"
$env:TF_CLI_CONFIG_FILE="c:/tf_cache/terraform.rc" 

for Ubuntu
export TF_PLUGIN_CACHE_DIR="c:/tf_cache"
export TF_CLI_CONFIG_FILE="c:/tf_cache/terraform.rc"

verify in Ubuntu
echo $TF_CLI_CONFIG_FILE

  ```

## Step 5: 
  create a directory to run your terraform code
  simply create a file main.tf
  write below code
  
  ```
  terraform {
  required_version ="~>1.1.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
}
```

## Step 6:
  This is GAME TIME !!
  Make sure you have your internet disconnected
  and run terraform init in your working directory. 
  If you have followed ablove steps properly, terraform init will pull the package from "tf_cache" to your working directory. It will NOT look for pulling from internet terraform registry. 
  
  A video tutorial will be published shortly here https://www.youtube.com/channel/UC5Juuk7aTvbRmrABMq4onJA/videos
  if interested join us at https://e2esolutionarchitect.com/
  
