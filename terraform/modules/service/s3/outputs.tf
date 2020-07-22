output "s3_bucket" {
  value = {
    domain        = aws_s3_bucket.domain
    resource      = aws_s3_bucket.resource
    audit         = aws_s3_bucket.audit
    logs          = aws_s3_bucket.logs
    codepipeline  = aws_s3_bucket.codepipeline
    backup        = aws_s3_bucket.backup
    vpc_flow_logs = aws_s3_bucket.vpc_flow_logs
    cloudtrail    = aws_s3_bucket.cloudtrail
  }
}
