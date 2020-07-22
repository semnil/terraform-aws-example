[
  {
    "image": "${image}",
    "name": "${prefix}-cron",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${awslogs_group}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${prefix}-cron"
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
        "name": "SQS_BACKEND",
        "value": "true"
      },
      {
        "name": "AWS_SQS_QUEUE_NAME",
        "value": "${aws_sqs_queue_name}"
      },
      {
        "name": "SENTRY_ENVIRONMENT",
        "value": "cron"
      }
    ],
    "command" : ${command}
  }
]
