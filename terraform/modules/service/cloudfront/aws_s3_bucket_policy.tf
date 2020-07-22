# aws_s3_bucket_policy
resource "aws_s3_bucket_policy" "domain" {
  bucket = var.s3_bucket.id
  policy = data.aws_iam_policy_document.cloudfront.json
}

data "aws_iam_policy_document" "cloudfront" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${var.s3_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.domain.iam_arn]
    }
  }
}
