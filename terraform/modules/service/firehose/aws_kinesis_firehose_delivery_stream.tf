resource "aws_kinesis_firehose_delivery_stream" "audit" {
  name        = "${var.prefix}-audit-${var.environment}"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn            = var.extended_s3_configuration.role_arn
    bucket_arn          = var.extended_s3_configuration.bucket_arn
    kms_key_arn         = var.extended_s3_configuration.kms_key_arn
    prefix              = var.extended_s3_configuration.prefix
    error_output_prefix = var.extended_s3_configuration.error_output_prefix
    compression_format  = var.extended_s3_configuration.compression_format
    buffer_size         = var.extended_s3_configuration.buffer_size
    buffer_interval     = var.extended_s3_configuration.buffer_interval

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = var.extended_s3_configuration.log_group_name
      log_stream_name = "S3Delivery"
    }
  }

  tags = {
    Environment = var.environment
  }
}
