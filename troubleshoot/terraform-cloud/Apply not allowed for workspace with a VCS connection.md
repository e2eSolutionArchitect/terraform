
Error

```
Run terraform apply -auto-approve
╷
│ Error: Apply not allowed for workspaces with a VCS connection
│ 
│ A workspace that is connected to a VCS requires the VCS-driven workflow to
│ ensure that the VCS remains the single source of truth.
```

Solution:

Use alternative run workflows such as **CLI driven** or **API run workflows driven** types that can be a consideration to execute runs within Terraform Cloud.

Sample Action run [here](https://github.com/TheSolutionArchitect/tf-aws-template-infra-core/actions/runs/12854022839)

TFC Version Control screen after removing VCS and selecting CLI driven run. 
![image](https://github.com/user-attachments/assets/9d75c916-b0e2-4437-8c6a-4f9ef98e6fae)

