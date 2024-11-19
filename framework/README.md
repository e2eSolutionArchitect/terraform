# Terraform Framework

- Modules: Cloud resource definitions
- Templates: Multiple modules integrated to build a solution
- Applications: Instance of the solution for a target environment. dev, stg, prod.


## Module structure:
- resources.tf : defines resources
- locals.tf : defines custom vars
- varibles.tf : defines variables
- output.tf : defines only the outputs that should be exposed to the other modules or templates
- README.md : module specification

## Template structure:
- config.tf : define TF versions, providers & remote state management
- resources.tf : defines resources
- locals.tf : defines custom vars
- varibles.tf : defines variables
- output.tf : defines only the outputs that should be exposed
- README.md : template specification
