data "aws_ecs_service" "app" {
  service_name = "${var.prefix}-app-${var.environment}"
  cluster_arn  = aws_ecs_cluster.this.arn
}

data "aws_ecs_task_definition" "app" {
  task_definition = data.aws_ecs_service.app.task_definition
}

data "aws_ecs_service" "worker" {
  service_name = "${var.prefix}-worker-${var.environment}"
  cluster_arn  = aws_ecs_cluster.this.arn
}

data "aws_ecs_task_definition" "worker" {
  task_definition = data.aws_ecs_service.worker.task_definition
}

data "aws_ecs_service" "parser" {
  service_name = "${var.prefix}-parser-${var.environment}"
  cluster_arn  = aws_ecs_cluster.this.arn
}

data "aws_ecs_task_definition" "parser" {
  task_definition = data.aws_ecs_service.parser.task_definition
}
