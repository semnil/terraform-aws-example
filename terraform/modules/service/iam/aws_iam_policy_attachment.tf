# app
resource "aws_iam_role_policy_attachment" "app_sqs" {
  role       = aws_iam_role.app.name
  policy_arn = aws_iam_policy.send_sqs.arn
}

resource "aws_iam_role_policy_attachment" "app_firehose" {
  role       = aws_iam_role.app.name
  policy_arn = aws_iam_policy.send_firehose.arn
}

# worker
resource "aws_iam_role_policy_attachment" "worker_firehose" {
  role       = aws_iam_role.worker.name
  policy_arn = aws_iam_policy.send_firehose.arn
}

# ssm
resource "aws_iam_role_policy_attachment" "ssm_firehose" {
  role       = aws_iam_role.ssm.name
  policy_arn = aws_iam_policy.send_firehose.arn
}

resource "aws_iam_role_policy_attachment" "ssm_ssm_managed_instance_core" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# cron
resource "aws_iam_role_policy_attachment" "cron_sqs" {
  role       = aws_iam_role.cron.name
  policy_arn = aws_iam_policy.send_sqs.arn
}

resource "aws_iam_role_policy_attachment" "cron_firehose" {
  role       = aws_iam_role.cron.name
  policy_arn = aws_iam_policy.send_firehose.arn
}

# execution
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# schedule
resource "aws_iam_role_policy_attachment" "schedule_ecs_events" {
  role       = aws_iam_role.schedule.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"
}

# rds_monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
