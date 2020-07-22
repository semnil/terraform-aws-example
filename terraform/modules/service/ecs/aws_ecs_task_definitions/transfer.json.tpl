[
  {
    "image": "${image}",
    "name": "${prefix}-transfer",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${prefix}-transfer",
        "awslogs-group": "${awslogs_group}"
      }
    },
    "mountPoints": [
      {
        "containerPath": "${mnt_path_shared}",
        "sourceVolume": "${mnt_volume_shared}"
      }
    ],
    "portMappings": [],
    "environment": [
      {
        "name": "MEMORY",
        "value": "${memory}"
      }
    ]
  }
]
