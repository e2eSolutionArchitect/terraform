
Refer here https://developer.hashicorp.com/terraform/tutorials/configuration-language/versions

Required Version	Meaning	Considerations
1.7.5	Only Terraform v1.7.5 exactly	To upgrade Terraform, first edit the required_version setting
>= 1.7.5	Any Terraform v1.7.5 or greater	Includes Terraform v2.0.0 and above
~> 1.7.5	Any Terraform v1.7.x, but not v1.8 or later	Minor version updates are intended to be non-disruptive
>= 1.7.5, < 1.9.5	Terraform v1.7.5 or greater, but less than v1.9.5	Avoids specific version updates
