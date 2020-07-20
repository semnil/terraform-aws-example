module "resourcegroup" {
  source      = "../../modules/resourcegroup"
  prefix      = var.prefix
  environment = var.environment
}
