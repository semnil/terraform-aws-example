output "ecs_cluster" {
  value = {
    this = aws_ecs_cluster.this
  }
}

output "ecs_service" {
  value = {
    app    = aws_ecs_service.app
    worker = aws_ecs_service.worker
    parser = aws_ecs_service.parser
  }
}
