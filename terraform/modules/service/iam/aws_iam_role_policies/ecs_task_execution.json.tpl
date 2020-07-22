{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Resource": "arn:aws:secretsmanager:${aws_region}:${account_id}:secret:${prefix}-app-${environment}-*"
    }
  ]
}
