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
        "awslogs-stream-prefix": "${prefix}-app"
      }
    },
    "portMappings": [
      {
        "containerPort": 3000
      }
    ],
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
        "name": "DEFAULT_DOMAIN",
        "value": "${default_domain}"
      },
      {
        "name": "OAUTH2_LOGIN_HOST",
        "value": "${oauth2_login_host}"
      },
      {
        "name": "RAILS_SERVE_STATIC_FILES",
        "value": "true"
      },
      {
        "name": "FORCE_SSL",
        "value": "true"
      },
      {
        "name": "SUBDOMAIN",
        "value": "true"
      },
      {
        "name": "QUERY_PARSER_PARSER_URI",
        "value": "${query_parser_parsed_uri}"
      },
      {
        "name": "S3_BUCKET",
        "value": "${s3_bucket}"
      },
      {
        "name": "REDIS_URL",
        "value": "${redis_url}"
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
        "value": "app"
      }
    ]
  }
]
