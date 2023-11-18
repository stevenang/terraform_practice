resource "aws_sns_topic" "this" {
  name       = var.fifo ? "${var.topic_name}.fifo" : var.topic_name
  fifo_topic = var.fifo
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    actions = [
      "SNS:Publish"
    ]
    effect = "Allow"
    resources = [
      aws_sns_topic.this.arn
    ]
    principals {
      type = "Service"
      identifiers = [
        "s3.amazonaws.com"
      ]
    }
    condition {
      test = "ArnLike"
      values = [
        var.s3_bucket_arn
      ]
      variable = "aws:SourceArn"
    }
  }
}

resource "aws_sns_topic_policy" "this" {
  arn    = aws_sns_topic.this.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic_subscription" "this" {
  count     = length(var.subscription_protocols)
  topic_arn = aws_sns_topic.this.arn
  protocol  = var.subscription_protocols[count.index]
  endpoint  = var.subscription_endpoints[count.index]
}

output "sns_topic_arn" {
  value = aws_sns_topic.this.arn
}