variable "fifo" {
  type    = bool
  default = false
}

variable "topic_name" {
  type = string
}

variable "s3_bucket_arn" {
  type = string
}

variable "subscription_protocols" {
  type = list(string)
}

variable "subscription_endpoints" {
  type = list(string)
}