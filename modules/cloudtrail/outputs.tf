output "kms_key_id" {
  value = aws_cloudtrail.this.kms_key_id
}

output "cloud_watch_logs_role_arn" {
  value = aws_cloudtrail.this.cloud_watch_logs_role_arn
}

output "this_trail_name" {
  value       = aws_cloudtrail.this.name
  description = "The name of the CloudTrail"
}

output "this_s3_bucket_name" {
  value       = aws_cloudtrail.this.s3_bucket_name
  description = "The S3 Bucketname which stores the CloudTrail logs"
}

output "bucket_policy_json" {
  description = "Complete TLS deny and CloudTrail delivery policy for an external policy owner."
  value       = data.aws_iam_policy_document.bucket_policy.json
}
