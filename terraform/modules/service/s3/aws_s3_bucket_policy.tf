# aws_s3_bucket_policy
resource "aws_s3_bucket_policy" "logs" {
  depends_on = [aws_s3_bucket_public_access_block.logs]
  bucket     = aws_s3_bucket.logs.id
  policy     = data.aws_iam_policy_document.public_alb_log.json
}

data "aws_iam_policy_document" "public_alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.logs.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.current.id]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudtrail" {
  depends_on = [aws_s3_bucket_public_access_block.cloudtrail]
  bucket     = aws_s3_bucket.cloudtrail.id
  policy     = data.aws_iam_policy_document.cloudtrail.json
}

data "aws_iam_policy_document" "cloudtrail" {
  statement {
    sid       = "AWSCloudTrailAclCheck20150319"
    effect    = "Allow"
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.cloudtrail.arn]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
  statement {
    sid       = "AWSCloudTrailWrite20150319"
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.cloudtrail.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = ["bucket-owner-full-control"]
    }
  }
}
