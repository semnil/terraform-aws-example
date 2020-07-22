{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:PutObject*",
        "s3:GetObject*",
        "s3:DeleteObject*"
      ],
      "Resource": [
      "arn:aws:s3:::datapia.jp",
      "arn:aws:s3:::datapia.jp/*",
        "arn:aws:s3:::${website_s3_bucket}",
        "arn:aws:s3:::${website_s3_bucket}/*"
      ]
    },
    {
      "Action": [
        "cloudfront:CreateInvalidation",
        "cloudfront:GetDistribution",
        "cloudfront:GetStreamingDistribution",
        "cloudfront:GetDistributionConfig",
        "cloudfront:GetInvalidation",
        "cloudfront:ListInvalidations",
        "cloudfront:ListStreamingDistributions",
        "cloudfront:ListDistributions"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
