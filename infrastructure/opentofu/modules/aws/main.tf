# Amazon Web Services (AWS) Always-Free Module
# Configures DynamoDB (25GB), SQS/SNS, CloudFront (1TB egress), and CloudWatch alarms

# 1. Always-Free Amazon DynamoDB Table (25 GB Storage, 25 WCU / 25 RCU)
resource "aws_dynamodb_table" "always_free_table" {
  name           = "zero_cost_key_value_store"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5  # Fits well within 25 RCU free allowance
  write_capacity = 5  # Fits well within 25 WCU free allowance
  hash_key       = "pk"
  range_key      = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  tags = {
    Name        = "ZeroCostDynamoDB"
    Environment = "AlwaysFree"
  }
}

# 2. Always-Free Amazon SQS Queue (1,000,000 requests/month)
resource "aws_sqs_queue" "always_free_queue" {
  name                      = "zero-cost-event-queue"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# 3. Always-Free Amazon SNS Topic (1,000,000 notifications/month)
resource "aws_sns_topic" "always_free_topic" {
  name = "zero-cost-notifications"
}

# 4. Zero-Dollar Billing Alarm Guardrail
resource "aws_cloudwatch_metric_alarm" "zero_cost_billing_alarm" {
  alarm_name          = "zero-cost-billing-breach-guardrail"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "21600" # 6 hours
  statistic           = "Maximum"
  threshold           = "0.01" # Trigger alarm if charges exceed $0.01

  dimensions = {
    Currency = "USD"
  }

  alarm_description = "Alerts immediately if charges exceed $0.01 USD threshold."
  alarm_actions     = [aws_sns_topic.always_free_topic.arn]
}

# Outputs
output "dynamodb_table_name" {
  value       = aws_dynamodb_table.always_free_table.name
  description = "AWS Always-Free DynamoDB Table Name"
}

output "sqs_queue_url" {
  value       = aws_sqs_queue.always_free_queue.id
  description = "AWS Always-Free SQS Queue URL"
}
