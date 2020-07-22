module "resourcegroup" {
  source      = "../../modules/resourcegroup"
  prefix      = var.prefix
  environment = var.environment
}

module "infra" {
  source         = "./modules/infra"
  environment    = var.environment
  prefix         = var.prefix
  domain_name    = var.domain_name
  release_tag    = var.release_tag
  vpc_cidr_block = var.vpc_cidr_block
  lb_ingress_ips = var.allow_public_access_ips
}

module "application" {
  source      = "./modules/application"
  environment = var.environment
  prefix      = var.prefix
  domain_name = var.domain_name
  release_tag = var.release_tag
  ecr         = data.terraform_remote_state.global.outputs.ecr
  kms         = module.infra.kms
  s3          = module.infra.s3
  iam         = module.infra.iam
  vpc         = module.infra.vpc
  # route53     = module.infra.route53
  cloudwatch = module.infra.cloudwatch
  aurora     = module.infra.aurora
  cache      = module.infra.cache
  efs        = module.infra.efs
  sqs        = module.infra.sqs
  secret     = module.infra.secret
  sns        = module.infra.sns
}
