{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sqs:GetQueueUrl",
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:ChangeMessageVisibility"
      ],
      "Resource": "arn:aws:sqs:${aws_region}:${account_id}:${prefix}-queue-${environment}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecs:ListTaskDefinitions",
        "ecs:DescribeTasks",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ecs:RunTask",
      "Resource": [
        "arn:aws:ecs:${aws_region}:${account_id}:task-definition/${prefix}-worker-${environment}:*",
        "arn:aws:ecs:${aws_region}:${account_id}:task-definition/${prefix}-transfer-${environment}:*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "iam:PassRole",
      "Resource": [
        "arn:aws:iam::${account_id}:role/${prefix}-worker-${environment}",
        "arn:aws:iam::${account_id}:role/${prefix}-ecs-task-execution-${environment}"
      ]
    }
  ]
}
