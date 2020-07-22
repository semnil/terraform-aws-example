output "sns_topic" {
  value = {
    chatbot = aws_sns_topic.chatbot
  }
}
