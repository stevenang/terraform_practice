locals {

}

resource "aws_s3_bucket" "this" {
    bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "this" {
    bucket = aws_s3_bucket.this.id
    rule {
        object_ownership = "BucketOwnerPreferred"
    }
}

resource "aws_s3_bucket_acl" "this" {
    bucket = aws_s3_bucket.this.id
    acl    = "public-read-write"
}

resource "aws_s3_bucket_notification" "this" {
    bucket = aws_s3_bucket.this.id
    topic {
        topic_arn     = var.topic_arn
        events        = ["s3:ObjectCreated:*"]
    }
}

output "bucket_arn" {
    value = aws_s3_bucket.this.arn
}
