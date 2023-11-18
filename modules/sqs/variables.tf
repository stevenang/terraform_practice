variable "queue_name" {
  description = "The name of the queue"
  type        = string
}

variable "fifo_queue" {
  type    = bool
  default = false
}