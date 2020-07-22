[
  {
    "image": "${image}",
    "name": "${prefix}-wp",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${awslogs_group}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${prefix}-wp"
      }
    },
    "mountPoints": [
      {
        "containerPath": "${mnt_path_shared}",
        "sourceVolume": "${mnt_volume_shared}"
      }
    ],
    "portMappings": [
      {
        "containerPort": 80
      }
    ],
    "environment": [
      {
        "name": "WORDPRESS_DB_USER",
        "value": "${db_username}"
      },
      {
        "name": "WORDPRESS_DB_NAME",
        "value": "${db_database}"
      },
      {
        "name": "WORDPRESS_DB_HOST",
        "value": "${db_endpoint}"
      },
      {
        "name": "WORDPRESS_DB_PASSWORD",
        "value": "${db_password}"
      }
    ]
  }
]
