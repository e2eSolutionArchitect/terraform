
```
Error: 
Could not download module "resourcegroup" (resourcegroup.tf:1) source code
from
"git::https://github.com/myorg/repo-module.git?ref=main":
error downloading
'https://github.com/myorg/repo-module.git?ref=main':
/usr/bin/git exited with 128: Cloning into
'.terraform/modules/resourcegroup'...
fatal: could not read Username for 'https://github.com': No such device or
address
```

Please check the [solution here](https://github.com/e2eSolutionArchitect/terraform/blob/main/docs/use-PAT-to-connect-module-repository.md)
