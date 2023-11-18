locals {
  queue_name = var.fifo_queue ? "${var.queue_name}.fifo" : var.queue_name
  dlq_name = var.fifo_queue ? "${var.queue_name}-dlq.fifo" : "${var.queue_name}-dlq"
}

resource "aws_sqs_queue" "this" {
  name       = var.is_dlq ? local.dlq_name : local.queue_name
  fifo_queue = var.fifo_queue
  redrive_policy = var.is_dlq ? null : jsonencode({
    deadLetterTargetArn = var.dlq_arn
    maxReceiveCount     = var.max_receive_count
  })
}

output "queue_url" {
  value = aws_sqs_queue.this.id
}

output "queue_arn" {
  value = aws_sqs_queue.this.arn
}