output "ecs_cluster" {
  value = {
    wp = aws_ecs_cluster.wp
  }
}

output "ecs_service" {
  value = {
    wp = aws_ecs_service.wp
  }
}
