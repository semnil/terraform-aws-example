module "kms" {
  source      = "../../../../modules/service/kms"
  environment = var.environment
  prefix      = var.prefix
}

module "secret" {
  source      = "../../../../modules/service/secret"
  environment = var.environment
  prefix      = var.prefix
}

module "backup" {
  source         = "../../../../modules/service/backup"
  environment    = var.environment
  prefix         = var.prefix
  aws_account_id = data.aws_caller_identity.current.account_id
}

module "s3" {
  source      = "../../../../modules/service/s3"
  environment = var.environment
  prefix      = var.prefix
  domain_name = var.domain_name
}

module "s3_object_log" {
  source         = "../../../../modules/service/s3_object_log"
  environment    = var.environment
  prefix         = var.prefix
  s3_bucket_name = module.s3.s3_bucket.cloudtrail.id
  s3_bucket_logging_arns = [
    module.s3.s3_bucket.domain.arn,
    module.s3.s3_bucket.resource.arn,
    module.s3.s3_bucket.audit.arn,
    module.s3.s3_bucket.codepipeline.arn,
    module.s3.s3_bucket.backup.arn,
  ]
  enable_logging = true
}

module "iam" {
  source               = "../../../../modules/service/iam"
  aws_region           = data.aws_region.current.name
  aws_account_id       = data.aws_caller_identity.current.account_id
  environment          = var.environment
  prefix               = var.prefix
  s3_bucket_audit      = module.s3.s3_bucket.audit.bucket
  audit_log_group_arn  = module.cloudwatch.cloudwatch_log_group.audit.arn
  kms_key_firehose     = module.kms.kms_key.firehose.arn
  kms_key_codepipeline = module.kms.kms_key.codepipeline.arn
}

module "vpc" {
  source                 = "../../../../modules/service/vpc"
  aws_region             = data.aws_region.current.name
  aws_availability_zones = data.aws_availability_zones.current
  environment            = var.environment
  prefix                 = var.prefix
  cidr_block             = var.vpc_cidr_block
  s3_bucket_arn          = module.s3.s3_bucket.vpc_flow_logs.arn
  lb_ingress_ips         = var.lb_ingress_ips
}

module "vpn" {
  source                 = "../../../../modules/service/vpn"
  aws_region             = data.aws_region.current.name
  aws_availability_zones = data.aws_availability_zones.current
  environment            = var.environment
  prefix                 = var.prefix
  vpc                    = module.vpc.vpc.this
  route_table_ids        = [module.vpc.route_table.private1.id]
  server_certificate_arn = "arn:aws:acm:ap-northeast-1:123456789000:certificate/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
  client_certificate_arn = "arn:aws:acm:ap-northeast-1:123456789000:certificate/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
  client_cidr_block      = "192.168.0.0/22"

}

# module "route53" {
#   source         = "../../../../modules/service/route53"
#   environment    = var.environment
#   prefix         = var.prefix
#   domain_name    = var.domain_name
#   vpc_id         = module.vpc.vpc.this.id
#   acm_validation = false
# }

module "waf" {
  source      = "../../../../modules/service/waf"
  environment = var.environment
  prefix      = var.prefix
  allow_public_access_ips = concat(
    var.lb_ingress_ips,
    module.vpc.eip.nat_gateway
  )
}

# module "cloudfront" {
#   source              = "../../../../modules/service/cloudfront"
#   environment         = var.environment
#   prefix              = var.prefix
#   domain_name         = var.domain_name
#   acm_certificate_arn = module.route53.acm_certificate.cloudfront.arn
#   s3_bucket           = module.s3.s3_bucket.domain
#   web_acl_id          = module.waf.waf_web_acl.this.id
# }

module "cloudwatch" {
  source      = "../../../../modules/service/cloudwatch"
  environment = var.environment
  prefix      = var.prefix
}

module "firehose" {
  source      = "../../../../modules/service/firehose"
  environment = var.environment
  prefix      = var.prefix

  extended_s3_configuration = {
    role_arn            = module.iam.iam_role.firehose.arn
    bucket_arn          = module.s3.s3_bucket.audit.arn
    kms_key_arn         = module.kms.kms_key.firehose.arn
    prefix              = "logs/dt=!{timestamp:yyyyMMdd}/"
    error_output_prefix = "errors/!{firehose:error-output-type}/dt=!{timestamp:yyyyMMdd}/"
    compression_format  = "GZIP"
    buffer_size         = 5
    buffer_interval     = 60
    log_group_name      = module.cloudwatch.cloudwatch_log_group.audit.name
  }
}

module "aurora" {
  source      = "../../../../modules/service/aurora"
  environment = var.environment
  prefix      = var.prefix
  subnet_ids  = module.vpc.subnet.datastore[*].id

  cluster_settings = {
    engine_version               = "10.12"
    backup_retention_period      = 5
    preferred_backup_window      = "19:30-20:00"
    preferred_maintenance_window = "wed:20:15-wed:20:45"
    port                         = 5432
    vpc_security_group_ids       = [module.vpc.security_group.rds.id]
    kms_key_id                   = module.kms.kms_key.rds.arn
    skip_final_snapshot          = false
    deletion_protection          = true
    number_db_clusters           = 2
  }

  instance_settings = {
    instance_class      = "db.t3.medium"
    monitoring_role_arn = module.iam.iam_role.rds_monitoring.arn
    monitoring_interval = 60
  }
}

module "cache" {
  source      = "../../../../modules/service/cache"
  environment = var.environment
  prefix      = var.prefix
  subnet_ids  = module.vpc.subnet.datastore[*].id

  cluster_settings = {
    engine_version           = "5.0.4"
    number_cache_clusters    = 3
    node_type                = "cache.t2.micro"
    snapshot_window          = "19:30-20:30"
    snapshot_retention_limit = 7
    maintenance_window       = "mon:21:00-mon:22:00"
    port                     = 6379
    security_group_ids       = [module.vpc.security_group.cache.id]
  }
}

module "efs" {
  source             = "../../../../modules/service/efs"
  environment        = var.environment
  prefix             = var.prefix
  subnet_ids         = module.vpc.subnet.datastore[*].id
  security_group_ids = [module.vpc.security_group.efs.id]
}

module "sqs" {
  source      = "../../../../modules/service/sqs"
  environment = var.environment
  prefix      = var.prefix

  queue_settings = {
    delay_seconds             = 5
    max_message_size          = 2048
    message_retention_seconds = 86400
    receive_wait_time_seconds = 10
    max_receive_count         = 4
  }

  deadletter_queue_settings = {
    delay_seconds             = 5
    max_message_size          = 2048
    message_retention_seconds = 86400
    receive_wait_time_seconds = 10
  }
}

module "sns" {
  source      = "../../../../modules/service/sns"
  environment = var.environment
  prefix      = var.prefix
}
