[
  {
    "image": "${image}",
    "name": "${prefix}-worker",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${awslogs_group}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${prefix}-worker"
      }
    },
    "mountPoints": [
      {
        "containerPath": "${mnt_path_shared}",
        "sourceVolume": "${mnt_volume_shared}"
      }
    ],
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
        "name": "EXECUTE_TASK_ENVIRONMENT",
        "value": "${environment}"
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
        "name": "QUERY_PARSER_PARSER_URI",
        "value": "${query_parser_parsed_uri}"
      },
      {
        "name": "REDIS_URL",
        "value": "${redis_url}"
      },
      {
        "name": "SENTRY_ENVIRONMENT",
        "value": "worker"
      },
      {
        "name": "MNT_TASK",
        "value": "${mnt_path_task}"
      },
      {
        "name": "MNT_SHARED",
        "value": "${mnt_path_shared}"
      },
      {
        "name": "TRANSFER_RUN_TASK",
        "value": "false"
      }
    ],
    "command" : ["bundle", "exec", "shoryuken", "-R", "-C", "config/shoryuken.yml"]
  }
]
