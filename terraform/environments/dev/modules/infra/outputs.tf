output "kms" {
  sensitive = true
  value     = module.kms
}

output "s3" {
  sensitive = true
  value     = module.s3
}

output "iam" {
  sensitive = true
  value     = module.iam
}

output "vpc" {
  sensitive = true
  value     = module.vpc
}

# output "route53" {
#   sensitive = true
#   value     = module.route53
# }

output "cloudwatch" {
  sensitive = true
  value     = module.cloudwatch
}

output "firehose" {
  sensitive = true
  value     = module.firehose
}

output "aurora" {
  sensitive = true
  value     = module.aurora
}

output "cache" {
  sensitive = true
  value     = module.cache
}

output "efs" {
  sensitive = true
  value     = module.efs
}

output "sqs" {
  sensitive = true
  value     = module.sqs
}

output "secret" {
  sensitive = true
  value     = module.secret
}

output "sns" {
  sensitive = true
  value     = module.sns
}
