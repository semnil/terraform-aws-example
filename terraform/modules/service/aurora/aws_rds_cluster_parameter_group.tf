# aws_rds_cluster_parameter_group
resource "aws_rds_cluster_parameter_group" "this" {
  name        = "${var.prefix}-aurora-postgresql10-${var.environment}"
  family      = "aurora-postgresql10"
  description = "Cluster parameter group for ${var.prefix} ${title(var.environment)}"

  parameter {
    name         = "lc_messages"
    value        = "ja_JP.UTF-8"
    apply_method = "immediate"
  }

  parameter {
    name         = "lc_monetary"
    value        = "ja_JP.UTF-8"
    apply_method = "immediate"
  }

  parameter {
    name         = "lc_numeric"
    value        = "ja_JP.UTF-8"
    apply_method = "immediate"
  }

  parameter {
    name         = "lc_time"
    value        = "ja_JP.UTF-8"
    apply_method = "immediate"
  }

  parameter {
    name         = "timezone"
    value        = "Asia/Tokyo"
    apply_method = "immediate"
  }

  parameter {
    name         = "datestyle"
    value        = "iso, ymd"
    apply_method = "immediate"
  }

  parameter {
    # DDL/DMLログ出力
    name         = "log_statement"
    value        = "all"
    apply_method = "immediate"
  }

  parameter {
    # スロークエリ閾値(ms)
    name         = "log_min_duration_statement"
    value        = 1 * 1000
    apply_method = "immediate"
  }

  parameter {
    # エラーログ出力
    name         = "log_min_error_statement"
    value        = "error"
    apply_method = "immediate"
  }

  tags = {
    Environment = var.environment
  }
}
