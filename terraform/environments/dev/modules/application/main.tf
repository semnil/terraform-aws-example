module "elb" {
  source      = "../../../../modules/service/elb"
  environment = var.environment
  prefix      = var.prefix
  domain_name = var.domain_name
  vpc_id      = var.vpc.vpc.this.id
  s3_bucket   = var.s3.s3_bucket.logs.id
  # certificate_arn           = var.route53.acm_certificate.this.arn
  # public_zone_id            = var.route53.route53_zone.this.zone_id
  # public_zone_name          = var.route53.route53_zone.this.name
  public_security_group_id = var.vpc.security_group.public_alb.id
  public_subnet_ids        = var.vpc.subnet.public_alb[*].id
  # private_zone_id           = var.route53.route53_zone.private.zone_id
  # private_zone_name         = var.route53.route53_zone.private.name
  private_security_group_id = var.vpc.security_group.private_alb.id
  private_subnet_ids        = var.vpc.subnet.private_alb[*].id
}

module "ecs" {
  source             = "../../../../modules/service/ecs"
  environment        = var.environment
  prefix             = var.prefix
  domain_name        = var.domain_name
  account_id         = data.aws_caller_identity.current.account_id
  aws_region         = data.aws_region.current.name
  vpc_id             = var.vpc.vpc.this.id
  execution_role_arn = var.iam.iam_role.ecs_task_execution.arn
  schedule_role_arn  = var.iam.iam_role.schedule.arn
  resource_s3_bucket = var.s3.s3_bucket.resource.id
  # query_parser_parsed_uri   = "http://${module.elb.route53_record.private_alb_parser.name}"
  query_parser_parsed_uri   = "http://parser.${var.domain_name}.local"
  aws_sqs_queue_name        = var.sqs.sqs_queue.queue.name
  redis_url                 = "redis://${var.cache.elasticache_replication_group.this.primary_endpoint_address}"
  aws_secretsmanager_secret = var.secret.secretsmanager_secret
  # Fargateに置き換え
  # auto_scaling_group_arn    = module.ec2.autoscaling_group.worker.arn

  app = {
    desired_count     = 1
    security_group_id = var.vpc.security_group.app.id
    subnet_ids        = var.vpc.subnet.app[*].id
    target_group_arn  = module.elb.lb_target_group.app.arn
    cpu               = 512
    memory            = 1024
    task_role_arn     = var.iam.iam_role.app.arn
    image             = "${var.ecr.ecr_repository.app.repository_url}:${var.release_tag}"
    awslogs_group     = var.cloudwatch.cloudwatch_log_group.app.name
  }

  worker = {
    desired_count     = 1
    security_group_id = var.vpc.security_group.worker.id
    subnet_ids        = var.vpc.subnet.worker[*].id
    cpu               = 256
    memory            = 1024
    task_role_arn     = var.iam.iam_role.worker.arn
    image             = "${var.ecr.ecr_repository.app.repository_url}:${var.release_tag}"
    awslogs_group     = var.cloudwatch.cloudwatch_log_group.worker.name
    efs_id            = var.efs.efs_file_system.shared.id
  }

  ssm = {
    desired_count     = 0
    security_group_id = var.vpc.security_group.worker.id
    subnet_ids        = var.vpc.subnet.worker[*].id
    cpu               = 256
    memory            = 512
    task_role_arn     = var.iam.iam_role.ssm.arn
    image             = "${var.ecr.ecr_repository.app.repository_url}:${var.release_tag}"
    awslogs_group     = var.cloudwatch.cloudwatch_log_group.ssm.name
    efs_id            = var.efs.efs_file_system.shared.id
  }

  parser = {
    desired_count     = 1
    security_group_id = var.vpc.security_group.parser.id
    subnet_ids        = var.vpc.subnet.parser[*].id
    target_group_arn  = module.elb.lb_target_group.parser.arn
    cpu               = 256
    memory            = 512
    image             = "${var.ecr.ecr_repository.parser.repository_url}:${var.release_tag}"
    awslogs_group     = var.cloudwatch.cloudwatch_log_group.parser.name
  }

  transfer = {
    security_group_id = var.vpc.security_group.transfer.id
    subnet_ids        = var.vpc.subnet.transfer[*].id
    cpu               = 256
    memory            = 1024
    image             = "${var.ecr.ecr_repository.transfer.repository_url}:${var.release_tag}"
    awslogs_group     = var.cloudwatch.cloudwatch_log_group.transfer.name
    efs_id            = var.efs.efs_file_system.shared.id
  }

  app_migration = {
    cpu           = 512
    memory        = 1024
    task_role_arn = var.iam.iam_role.app.arn
    image         = "${var.ecr.ecr_repository.app.repository_url}:${var.release_tag}"
    awslogs_group = var.cloudwatch.cloudwatch_log_group.app.name
  }

  app_seed = {
    cpu           = 512
    memory        = 1024
    task_role_arn = var.iam.iam_role.app.arn
    image         = "${var.ecr.ecr_repository.app.repository_url}:${var.release_tag}"
    awslogs_group = var.cloudwatch.cloudwatch_log_group.app.name
  }

  cron_synchronize_metastore_daily_job = {
    security_group_id = var.vpc.security_group.worker.id
    subnet_ids        = var.vpc.subnet.worker[*].id
    cpu               = 256
    memory            = 512
    task_role_arn     = var.iam.iam_role.cron.arn
    image             = "${var.ecr.ecr_repository.app.repository_url}:${var.release_tag}"
    awslogs_group     = var.cloudwatch.cloudwatch_log_group.cron.name
  }

  cron_enqueue_scheduled_workflow_job = {
    security_group_id = var.vpc.security_group.worker.id
    subnet_ids        = var.vpc.subnet.worker[*].id
    cpu               = 256
    memory            = 512
    task_role_arn     = var.iam.iam_role.cron.arn
    image             = "${var.ecr.ecr_repository.app.repository_url}:${var.release_tag}"
    awslogs_group     = var.cloudwatch.cloudwatch_log_group.cron.name
  }

  cron_recover_query_operation_job = {
    security_group_id = var.vpc.security_group.worker.id
    subnet_ids        = var.vpc.subnet.worker[*].id
    cpu               = 256
    memory            = 512
    task_role_arn     = var.iam.iam_role.cron.arn
    image             = "${var.ecr.ecr_repository.app.repository_url}:${var.release_tag}"
    awslogs_group     = var.cloudwatch.cloudwatch_log_group.cron.name
  }
}

# Fargateに置き換え
# module "ec2" {
#   source            = "../../../../modules/service/ec2"
#   environment       = var.environment
#   prefix            = var.prefix
#   instance_type     = "t3.medium"
#   spot_price        = "0.04"
#   security_group_id = var.vpc.security_group.worker.id
#   cluster_name      = "${var.prefix}-${var.environment}"
#   max_size          = 2
#   min_size          = 0
#   desired_capacity  = 1
#   subnet_ids        = var.vpc.subnet.worker[*].id
# }

module "codepipeline" {
  source                 = "../../../../modules/service/codepipeline"
  environment            = var.environment
  prefix                 = var.prefix
  release_tag            = var.release_tag
  app_repository_name    = var.ecr.ecr_repository.app.name
  app_repository_url     = var.ecr.ecr_repository.app.repository_url
  parser_repository_name = var.ecr.ecr_repository.parser.name
  parser_repository_url  = var.ecr.ecr_repository.parser.repository_url
  s3_bucket              = var.s3.s3_bucket.codepipeline.id
  role_arn               = var.iam.iam_role.codepipeline.arn
  kms_key_arn            = var.kms.kms_key.codepipeline.arn
  cluster_name           = module.ecs.ecs_cluster.this.name
  app_service_name       = module.ecs.ecs_service.app.name
  worker_service_name    = module.ecs.ecs_service.worker.name
  parser_service_name    = module.ecs.ecs_service.parser.name
  approval_app           = false
  approval_parser        = false
  events_role_arn        = var.iam.iam_role.events_codepipeline.arn
}

module "cloudwatch_alarm" {
  source        = "../../../../modules/service/cloudwatch_alarm"
  environment   = var.environment
  prefix        = var.prefix
  sns_topic_arn = var.sns.sns_topic.chatbot.arn
  public_alb = {
    name = module.elb.lb_target_group.app.name
    dimensions = {
      alb          = module.elb.lb.public_alb.arn_suffix
      target_group = module.elb.lb_target_group.app.arn_suffix
    }
  }
  private_alb = {
    name = module.elb.lb_target_group.parser.name
    dimensions = {
      alb          = module.elb.lb.private_alb.arn_suffix
      target_group = module.elb.lb_target_group.parser.arn_suffix
    }
  }
  aurora = {
    name = var.aurora.rds_cluster.this.cluster_identifier
    dimensions = {
      cluster = var.aurora.rds_cluster.this.cluster_identifier
    }
  }
  ecs_app = {
    name = module.ecs.ecs_service.app.name
    dimensions = {
      cluster = module.ecs.ecs_cluster.this.name
      service = module.ecs.ecs_service.app.name
    }
  }
  ecs_worker = {
    name = module.ecs.ecs_service.worker.name
    dimensions = {
      cluster = module.ecs.ecs_cluster.this.name
      service = module.ecs.ecs_service.worker.name
    }
  }
  ecs_parser = {
    name = module.ecs.ecs_service.parser.name
    dimensions = {
      cluster = module.ecs.ecs_cluster.this.name
      service = module.ecs.ecs_service.parser.name
    }
  }
  # Fargateに置き換え
  # ec2 = {
  #   name = module.ec2.autoscaling_group.worker.name
  #   dimensions = {
  #     autoscaling_group = module.ec2.autoscaling_group.worker.name
  #   }
  # }
}

module "wordpress" {
  source                 = "../../../../modules/service/wordpress"
  environment            = var.environment
  prefix                 = var.prefix
  domain_name            = var.domain_name
  aws_region             = data.aws_region.current.name
  vpc_id                 = var.vpc.vpc.this.id
  cidr_block             = var.vpc.vpc.this.cidr_block
  ingress_security_group = var.vpc.security_group.public_alb
  # lb_listener_arn        = module.elb.lb_listener.public_alb_https.arn
  lb_listener_arn        = module.elb.lb_listener.public_alb_http.arn
  website_s3_bucket      = var.s3.s3_bucket.domain.id
  execution_role_arn     = var.iam.iam_role.ecs_task_execution.arn
  subnet_ids             = var.vpc.subnet.app[*].id
  db_subnet_group_name   = var.aurora.db_subnet_group.this.name
  db_kms_key_id          = var.kms.kms_key.rds.arn
  datastore_subnet_ids   = var.vpc.subnet.datastore[*].id
  efs_security_group_ids = [var.vpc.security_group.efs.id]
  sns_topic_arn          = var.sns.sns_topic.chatbot.arn
}
