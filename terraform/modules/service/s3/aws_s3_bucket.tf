# aws_s3_bucket (server access logs)
resource "aws_s3_bucket" "s3_access_logs" {
  bucket = "${var.prefix}-s3-access-logs-${var.environment}"
  acl    = "log-delivery-write"

  tags = {
    Environment = var.environment
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    expiration {
      days = 30
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

# aws_s3_bucket
resource "aws_s3_bucket" "domain" {
  bucket = var.domain_name
  acl    = "public-read"

  logging {
    target_bucket = aws_s3_bucket.s3_access_logs.bucket
    target_prefix = "${var.domain_name}/"
  }

  website {
    index_document = "index.html"
    error_document = "404notfound/index.html"
  }

  tags = {
    Environment = var.environment
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "resource" {
  bucket = "${var.prefix}-resource-${var.environment}"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.s3_access_logs.bucket
    target_prefix = "${var.prefix}-resource-${var.environment}/"
  }

  tags = {
    Environment = var.environment
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "audit" {
  bucket = "${var.prefix}-audit-${var.environment}"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.s3_access_logs.bucket
    target_prefix = "${var.prefix}-audit-${var.environment}/"
  }

  tags = {
    Environment = var.environment
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${var.prefix}-logs-${var.environment}"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.s3_access_logs.bucket
    target_prefix = "${var.prefix}-logs-${var.environment}/"
  }

  tags = {
    Environment = var.environment
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    expiration {
      days = 60
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "codepipeline" {
  bucket = "${var.prefix}-codepipeline-${var.environment}"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.s3_access_logs.bucket
    target_prefix = "${var.prefix}-codepipeline-${var.environment}/"
  }

  versioning {
    enabled = true
  }

  tags = {
    Environment = var.environment
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "backup" {
  bucket = "${var.prefix}-backup-${var.environment}"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.s3_access_logs.bucket
    target_prefix = "${var.prefix}-backup-${var.environment}/"
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    noncurrent_version_expiration {
      days = 32
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Environment = var.environment
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "vpc_flow_logs" {
  bucket = "${var.prefix}-vpc-flow-logs-${var.environment}"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.s3_access_logs.bucket
    target_prefix = "${var.prefix}-vpc-flow-logs-${var.environment}/"
  }

  tags = {
    Environment = var.environment
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    expiration {
      days = 60
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "cloudtrail" {
  bucket = "${var.prefix}-cloudtrail-${var.environment}"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.s3_access_logs.bucket
    target_prefix = "${var.prefix}-cloudtrail-${var.environment}/"
  }

  tags = {
    Environment = var.environment
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    expiration {
      days = 60
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
