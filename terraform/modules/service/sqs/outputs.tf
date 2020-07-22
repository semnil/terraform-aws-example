output "sqs_queue" {
  value = {
    queue = aws_sqs_queue.queue
  }
}
