
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

Use alternative run workflows such as CLI driven or API run workflows driven types that can be a consideration to execute runs within Terraform Cloud.

