# aws_kms_key
resource "aws_kms_key" "rds" {
  description             = "${var.prefix} ${title(var.environment)} master key that protects my RDS database volumes"
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 30

  tags = {
    Environment = var.environment
  }
}

resource "aws_kms_key" "firehose" {
  description             = "${var.prefix} ${title(var.environment)} master key that protects my KinesisDataFirehose S3"
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 30

  tags = {
    Environment = var.environment
  }
}

resource "aws_kms_key" "codepipeline" {
  description             = "${var.prefix} ${title(var.environment)} master key that protects my CodepiPeline S3"
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 30

  tags = {
    Environment = var.environment
  }
}

# aws_kms_alias
resource "aws_kms_alias" "rds" {
  name          = "alias/${var.prefix}/${var.environment}/rds"
  target_key_id = aws_kms_key.rds.key_id
}

resource "aws_kms_alias" "firehose" {
  name          = "alias/${var.prefix}/${var.environment}/firehose"
  target_key_id = aws_kms_key.firehose.key_id
}

resource "aws_kms_alias" "codepipeline" {
  name          = "alias/${var.prefix}/${var.environment}/codepipeline"
  target_key_id = aws_kms_key.codepipeline.key_id
}
