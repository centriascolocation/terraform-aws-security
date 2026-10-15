output "bucket_id" {
  value = aws_s3_bucket.config.id
}

output "bucket_arn" {
  value = aws_s3_bucket.config.arn
}

output "recorder_role_arn" {
  value = aws_config_configuration_recorder.config.role_arn
}

output "bucket_policy_statements" {
  value = data.aws_iam_policy_document.bucket_policy.statement
}

output "aws_config_configuration_recorder_id" {
  description = "Configuration of created config recorder resource"
  value       = aws_config_configuration_recorder.config.id
}
