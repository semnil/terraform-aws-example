variable "environment" {}

variable "prefix" {}

variable "subnet_ids" {}

variable "cluster_settings" {
  type = object({
    engine_version           = string
    number_cache_clusters    = number
    node_type                = string
    snapshot_window          = string
    snapshot_retention_limit = number
    maintenance_window       = string
    port                     = number
    security_group_ids       = list(string)
  })
}
