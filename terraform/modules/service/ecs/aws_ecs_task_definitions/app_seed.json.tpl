[
  {
    "image": "${image}",
    "name": "${prefix}-app-seed",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${awslogs_group}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${prefix}-app-seed"
      }
    },
    "portMappings": [],
    "secrets": [
      {
        "name": "SECRETS_JSON",
        "valueFrom": "${aws_secretsmanager_secret_arn}"
      }
    ],
    "environment": [
      {
        "name": "AWS_REGION",
        "value": "${aws_region}"
      },
      {
        "name": "RAILS_LOG_TO_STDOUT",
        "value": "true"
      },
      {
        "name": "SENTRY_ENVIRONMENT",
        "value": "app"
      }
    ],
    "command" : ["bundle", "exec", "rake", "db:seed"]
  }
]
