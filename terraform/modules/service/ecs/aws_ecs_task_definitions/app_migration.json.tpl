[
  {
    "image": "${image}",
    "name": "${prefix}-app",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${awslogs_group}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${prefix}-app-migration"
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
        "name": "DATABASE_URL",
        "value": ""
      },
      {
        "name": "POSTGRES_ENCRYPTOR_IV",
        "value": ""
      },
      {
        "name": "POSTGRES_ENCRYPTOR_KEY",
        "value": ""
      },
      {
        "name": "SECRET_KEY_BASE",
        "value": ""
      },
      {
        "name": "SENTRY_ENVIRONMENT",
        "value": "app"
      }
    ],
    "command" : ["bundle", "exec", "rake", "db:migrate"]
  }
]
