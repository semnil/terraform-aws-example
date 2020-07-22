resource "aws_cloudtrail" "data_trail" {
  name                          = "${var.prefix}-data-trail-${var.environment}"
  s3_bucket_name                = var.s3_bucket_name
  s3_key_prefix                 = ""
  is_multi_region_trail         = false
  include_global_service_events = false
  enable_log_file_validation    = true
  enable_logging                = var.enable_logging

  tags = {
    Environment = var.environment
  }

  event_selector {
    read_write_type           = "All"
    include_management_events = false

    data_resource {
      type = "AWS::S3::Object"
      # Make sure to append a trailing '/' to your ARN if you want
      # to monitor all objects in a bucket.
      values = [
        for s3_bucket_arn in var.s3_bucket_logging_arns :
        "${s3_bucket_arn}/"
      ]
    }
  }
}
