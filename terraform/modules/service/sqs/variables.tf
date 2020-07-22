variable "environment" {}

variable "prefix" {}

variable "queue_settings" {
  type = object({
    delay_seconds             = number
    max_message_size          = number
    message_retention_seconds = number
    receive_wait_time_seconds = number
    max_receive_count         = number
  })
}

variable "deadletter_queue_settings" {
  type = object({
    delay_seconds             = number
    max_message_size          = number
    message_retention_seconds = number
    receive_wait_time_seconds = number
  })
}
