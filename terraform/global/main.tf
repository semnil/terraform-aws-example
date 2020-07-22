module "config" {
  source      = "./modules/config"
  prefix      = var.prefix
  environment = var.environment
}

module "securityhub" {
  source = "./modules/securityhub"
}

module "guardduty" {
  source = "./modules/guardduty"
}

module "cloudtrail" {
  source         = "./modules/cloudtrail"
  aws_account_id = data.aws_caller_identity.current.account_id
  prefix         = var.prefix
  environment    = var.environment
}

module "iam_user" {
  source         = "./modules/iam_user"
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_region     = data.aws_region.current.name
  prefix         = var.prefix
}

module "ecr" {
  source      = "./modules/ecr"
  prefix      = var.prefix
  environment = var.environment
}

module "secret_global" {
  source      = "./modules/secret_global"
  prefix      = var.prefix
  environment = var.environment
}

module "resourcegroup" {
  source      = "../modules/resourcegroup"
  prefix      = var.prefix
  environment = var.environment
}
