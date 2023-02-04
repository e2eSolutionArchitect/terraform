[
    {
        "name": "${app_name}",
        "image": "${app_image}",
        "cpu": "${fargate_cpu}",
        "memory": "${fargate_cpu_memory}",
        "networkMode": "${network_mode}",
        "workingDirectory": "${working_directory}",
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group":"${awslogs_group_name}",
                "awslogs-region":"${aws_region}",
                "awslogs-stream-prefix": "${awslogs_stream_prefix}"
            }
        },
        "portMappings": [
            {
                "containerPort":8001,
                "hostPort":8001
            },{
                "containerPort":8002,
                "hostPort":8002
            },{
                "containerPort":8443,
                "hostPort":8443
            }
        ],
        "mountPoints":[
            {
                "containerPath":"${container_path}",
                "sourceVolume": "${source_volumn}"
            }
        ]
    }
]