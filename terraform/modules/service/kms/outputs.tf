output "kms_key" {
  value = {
    rds          = aws_kms_key.rds
    firehose     = aws_kms_key.firehose
    codepipeline = aws_kms_key.codepipeline
  }
}

output "kms_alias" {
  value = {
    rds          = aws_kms_alias.rds
    firehose     = aws_kms_alias.firehose
    codepipeline = aws_kms_alias.codepipeline
  }
}
