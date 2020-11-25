output "this_trail_name" {
  value       = aws_cloudtrail.this.name
  description = "The name of the CloudTrail"
}

output "this_s3_bucket_name" {
  value       = aws_cloudtrail.this.s3_bucket_name
  description = "The S3 Bucketname which stores the CloudTrail logs"
}
