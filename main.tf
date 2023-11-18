terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.24.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_force_path_style         = true

  endpoints {
    acm            = "http://localhost:4566"
    apigateway     = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    ec2            = "http://localhost:4566"
    es             = "http://localhost:4566"
    firehose       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    kinesis        = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    rds            = "http://localhost:4566"
    redshift       = "http://localhost:4566"
    route53        = "http://localhost:4566"
    s3             = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
    ses            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
    stepfunctions  = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}

module "test_s3_bucket-01" {
  source      = "./modules/s3"
  bucket_name = "test-bucket-01"
  topic_arn   = module.test_sns_topic-01.sns_topic_arn
}

module "test_sqs_queue-01" {
  source      = "./modules/sqs"
  queue_name  = "test-queue-01"
  fifo_queue  = true
}

module "test_sns_topic-01" {
  source        = "./modules/sns"
  topic_name    = "test-topic-01"
  s3_bucket_arn = module.test_s3_bucket-01.bucket_arn
  fifo = true
  subscription_protocols = ["sqs"]
  subscription_endpoints = [module.test_sqs_queue-01.queue_arn]
}

module "test_s3_bucket-02" {
  source      = "./modules/s3"
  bucket_name = "test-bucket-02"
  topic_arn   = module.test_sns_topic-02.sns_topic_arn
}

module "test_sqs_queue-02" {
  source      = "./modules/sqs"
  queue_name  = "test-queue-02"
}

module "test_sns_topic-02" {
  source        = "./modules/sns"
  topic_name    = "test-topic-02"
  s3_bucket_arn = module.test_s3_bucket-02.bucket_arn
  subscription_protocols = ["sqs"]
  subscription_endpoints = [module.test_sqs_queue-02.queue_arn]
}

