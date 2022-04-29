Install Docker on Ubuntu (Click here)[https://github.com/e2eSolutionArchitect/scripts/blob/main/docker/install-docker-aws-ec2.md] on AWS EC2 (Click here)[https://github.com/e2eSolutionArchitect/scripts/blob/main/docker/install-docker-aws-ec2.md]


Run terraform docker with below command

```
docker run --rm -v $PWD:/data -v $PWD/..modules:/modules -v /opt/terraform/tf_cache:/tf_cache -v /home/ec2-user/.aws:/root/.aws -w /data -e TF_PLUGIN_CACHE_DIR="/tf_cache" -e TF_CLI_CONFIG_FILE="/tf_cache/.terraformrc" hashicorp/terraform:1.1.8 init

docker run --rm -v $PWD:/data -v $PWD/..modules:/modules -v /opt/terraform/tf_cache:/tf_cache -v /home/ec2-user/.aws:/root/.aws -w /data -e TF_PLUGIN_CACHE_DIR="/tf_cache" -e TF_CLI_CONFIG_FILE="/tf_cache/.terraformrc" hashicorp/terraform:1.1.8 apply  -var-file="app.tfvars" -var="creator=e2esa" -auto-appprove
```
