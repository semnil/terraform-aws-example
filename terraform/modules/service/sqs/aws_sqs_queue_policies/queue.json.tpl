{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${queue_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${queue_arn}"
        }
      }
    }
  ]
}
