
# As part of TF deployment automation, TF Plan and Apply are performed on separate job or workflow. 

However this approach creates [inconsistent dependency lock](https://github.com/e2eSolutionArchitect/terraform/blob/main/troubleshoot/Inconsistent-dependency-lock-file.md).
Please check here for the complete pipelines to handle TF Plan and Apply in different job or separate systems.
