{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:AbortMultipartUpload",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:PutObject"
      ],
      "Resource": [
          "arn:aws:s3:::${s3_bucket}",
          "arn:aws:s3:::${s3_bucket}/*"
      ]
    },
    {
        "Effect": "Allow",
        "Action": [
            "logs:PutLogEvents"
        ],
        "Resource": [
            "${log_group_arn}:*"
        ]
    },
    {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": "kms:*",
        "Resource": "${kms_key_arn}"
    }
  ]
}
