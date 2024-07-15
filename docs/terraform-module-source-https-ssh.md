
## The  custom modules fetch module source using 'source'. It could be either local source or remote source. 

# For local source 
```
module "ec2" {
  #source = "../../modules/e2esa-module-aws-ec2"
  .....
}
```

# For remote source  - HTTPS

```
module "ec2" {
  source = "git::https://github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-ec2?ref=main"
  .....
}

# here ref=main is particularly referring to a branch. it could be ref=v1.0.1. where v1.0.1 is a release tag.
# also don't miss the '//'
```

# For remote source  - SSH

```
module "ec2" {
  source = "git::ssh://git@github.com/e2eSolutionArchitect/terraform.git//providers/aws/modules/e2esa-module-aws-ec2?ref=main"
  .....
}
# ensure that you have SSH private ket setup
```

# for module from a public repo for a specific release v1.0.0
```
# here module is in repo root
source = "git::https://github.com/e2eSolutionArchitect/terraform-aws-apigw.git?ref=v1.0.0"
```
