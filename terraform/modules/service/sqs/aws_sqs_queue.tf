# aws_sqs_queue
resource "aws_sqs_queue" "queue" {
  name                      = "${var.prefix}-queue-${var.environment}"
  delay_seconds             = var.queue_settings.delay_seconds
  max_message_size          = var.queue_settings.max_message_size
  message_retention_seconds = var.queue_settings.message_retention_seconds
  receive_wait_time_seconds = var.queue_settings.receive_wait_time_seconds

  redrive_policy = "{\"deadLetterTargetArn\": \"${aws_sqs_queue.queue_deadletter.arn}\",\"maxReceiveCount\": ${var.queue_settings.max_receive_count}}"

  tags = {
    Environment = var.environment
  }
}

resource "aws_sqs_queue" "queue_deadletter" {
  name                      = "${var.prefix}-queue-deadletter-${var.environment}"
  delay_seconds             = var.deadletter_queue_settings.delay_seconds
  max_message_size          = var.deadletter_queue_settings.max_message_size
  message_retention_seconds = var.deadletter_queue_settings.message_retention_seconds
  receive_wait_time_seconds = var.deadletter_queue_settings.receive_wait_time_seconds

  tags = {
    Environment = var.environment
  }
}

# aws_sqs_queue_policy
resource "aws_sqs_queue_policy" "queue" {
  queue_url = aws_sqs_queue.queue.id

  policy = templatefile("${path.module}/aws_sqs_queue_policies/queue.json.tpl",
    {
      queue_arn = aws_sqs_queue.queue.arn
    }
  )
}
