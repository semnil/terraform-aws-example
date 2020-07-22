[
  {
    "image": "${image}",
    "name": "${prefix}-parser",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${prefix}-parser",
        "awslogs-group": "${awslogs_group}"
      }
    },
    "portMappings": [
      {
        "containerPort": 3000
      }
    ]
  }
]
