resource "aws_sqs_queue" "this" {
  name = var.fifo_queue ? "${var.queue_name}.fifo" : var.queue_name
  fifo_queue = var.fifo_queue
}

resource "aws_sqs_queue" "dead_letter_queue" {
  name = "${var.queue_name}-dead-letter"
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns = [aws_sqs_queue.this.arn]
  })
}

output "queue_url" {
  value = aws_sqs_queue.this.id
}

output "queue_arn" {
  value = aws_sqs_queue.this.arn
}