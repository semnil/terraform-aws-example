module "vpc" {
  source                 = "./vpc"
  environment            = var.environment
  prefix                 = var.prefix
  vpc_id                 = var.vpc_id
  cidr_block             = var.cidr_block
  ingress_security_group = var.ingress_security_group
}

module "elb" {
  source          = "./elb"
  environment     = var.environment
  prefix          = var.prefix
  domain_name     = var.domain_name
  vpc_id          = var.vpc_id
  lb_listener_arn = var.lb_listener_arn
}

module "iam" {
  source            = "./iam"
  environment       = var.environment
  prefix            = var.prefix
  website_s3_bucket = var.website_s3_bucket
}

module "cloudwatch" {
  source      = "./cloudwatch"
  environment = var.environment
  prefix      = var.prefix
}

module "secret" {
  source      = "./secret"
  environment = var.environment
  prefix      = var.prefix
}

module "efs" {
  source             = "./efs"
  environment        = var.environment
  prefix             = var.prefix
  subnet_ids         = var.datastore_subnet_ids
  security_group_ids = var.efs_security_group_ids
}

# Fargateに置き換え
module "ec2" {
  source               = "./ec2"
  environment          = var.environment
  prefix               = var.prefix
  instance_type        = "t3.small"
  spot_price           = "0.02"
  iam_instance_profile = module.iam.iam_instance_profile.wp_ec2.name
  security_group_id    = module.vpc.security_group.wp.id
  cluster_name         = "${var.prefix}-wp-${var.environment}"
  max_size             = 2
  min_size             = 0
  desired_capacity     = 1
  subnet_ids           = var.subnet_ids
}

module "ecs" {
  source             = "./ecs"
  environment        = var.environment
  prefix             = var.prefix
  domain_name        = var.domain_name
  aws_region         = var.aws_region
  execution_role_arn = var.execution_role_arn
  database           = module.aurora.rds_cluster.wp
  task_config = {
    desired_count     = 1
    cpu               = 512
    memory            = 1024
    subnet_ids        = var.subnet_ids
    security_group_id = module.vpc.security_group.wp.id
    target_group_arn  = module.elb.lb_target_group.wp.arn
    task_role_arn     = module.iam.iam_role.wp.arn
    image             = "wordpress:5.2.4"
    awslogs_group     = module.cloudwatch.cloudwatch_log_group.wp.name
    efs_id            = module.efs.efs_file_system.wp_shared.id
  }
}

module "aurora" {
  source               = "./aurora"
  environment          = var.environment
  prefix               = var.prefix
  db_subnet_group_name = var.db_subnet_group_name

  cluster_settings = {
    engine_version               = "5.6.10a"
    backup_retention_period      = 5
    preferred_backup_window      = "19:30-20:00"
    preferred_maintenance_window = "wed:20:15-wed:20:45"
    port                         = 3306
    vpc_security_group_ids       = [module.vpc.security_group.mysql.id]
    kms_key_id                   = var.db_kms_key_id
    skip_final_snapshot          = false
    deletion_protection          = true
  }
}

module "cloudwatch_alarm" {
  source        = "./cloudwatch_alarm"
  environment   = var.environment
  prefix        = var.prefix
  sns_topic_arn = var.sns_topic_arn
  public_alb = {
    name = module.elb.lb_target_group.wp.name
    dimensions = {
      alb          = data.aws_lb.public_alb.arn_suffix
      target_group = module.elb.lb_target_group.wp.arn_suffix
    }
  }
  aurora = {
    name = module.aurora.rds_cluster.wp.cluster_identifier
    dimensions = {
      cluster = module.aurora.rds_cluster.wp.cluster_identifier
    }
  }
  ecs = {
    name = module.ecs.ecs_service.wp.name
    dimensions = {
      cluster = module.ecs.ecs_cluster.wp.name
      service = module.ecs.ecs_service.wp.name
    }
  }
  # Fargateに置き換え
  # ec2 = {
  #   name = module.ec2.autoscaling_group.wp.name
  #   dimensions = {
  #     autoscaling_group = module.ec2.autoscaling_group.wp.name
  #   }
  # }
}
