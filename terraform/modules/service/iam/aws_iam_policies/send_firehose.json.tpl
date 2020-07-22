{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "firehose:PutRecord",
      "Resource": "arn:aws:firehose:${aws_region}:${account_id}:deliverystream/${prefix}-audit-${environment}"
    }
  ]
}
