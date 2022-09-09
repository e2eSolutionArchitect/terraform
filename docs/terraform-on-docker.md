Install Docker on Ubuntu [Click here](https://github.com/e2eSolutionArchitect/scripts/blob/main/docker/install-docker-ubuntu.md) on AWS EC2 [Click here](https://github.com/e2eSolutionArchitect/scripts/blob/main/docker/install-docker-aws-ec2.md)

Setup Terraform cache with file system mirror (creating tf_cache) [Click here](https://github.com/e2eSolutionArchitect/terraform/blob/main/docs/terraform-offline-initialize.md)

Run terraform docker with below command

```
docker run --rm -v $PWD:/data -v $PWD/..modules:/modules -v /opt/terraform/tf_cache:/tf_cache -v /home/ec2-user/.aws:/root/.aws -w /data -e TF_PLUGIN_CACHE_DIR="/tf_cache" -e TF_CLI_CONFIG_FILE="/tf_cache/.terraformrc" hashicorp/terraform:1.1.8 init

docker run --rm -v $PWD:/data -v $PWD/..modules:/modules -v /opt/terraform/tf_cache:/tf_cache -v /home/ec2-user/.aws:/root/.aws -w /data -e TF_PLUGIN_CACHE_DIR="/tf_cache" -e TF_CLI_CONFIG_FILE="/tf_cache/.terraformrc" hashicorp/terraform:1.1.8 apply  -var-file="app.tfvars" -var="creator=e2esa" -auto-appprove
```

Enable log? add -e TF_LOG="trace/verbose/info"

``
docker run --rm -v $PWD:/data -v $PWD/..modules:/modules -v /opt/terraform/tf_cache:/tf_cache -v /home/ec2-user/.aws:/root/.aws -w /data -e TF_PLUGIN_CACHE_DIR="/tf_cache" -e TF_CLI_CONFIG_FILE="/tf_cache/.terraformrc" -e TF_LOG="trace" hashicorp/terraform:1.1.8 init
``

Specify STS endpoint while trigging Terraform . add e- AWS_STS_REGIONAL_ENDPOINTS="regional"

``
docker run --rm -v $PWD:/data -v $PWD/..modules:/modules -v /opt/terraform/tf_cache:/tf_cache -v /home/ec2-user/.aws:/root/.aws -w /data -e TF_PLUGIN_CACHE_DIR="/tf_cache" -e TF_CLI_CONFIG_FILE="/tf_cache/.terraformrc" e- AWS_STS_REGIONAL_ENDPOINTS="regional" hashicorp/terraform:1.1.8 init
``
