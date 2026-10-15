output "this_bucket" {
  description = "This S3 bucket. Stable metadata only; legacy inline configuration attributes are not exported."
  value = var.enabled ? {
    id                          = aws_s3_bucket.secure_s3_bucket[0].id
    arn                         = aws_s3_bucket.secure_s3_bucket[0].arn
    bucket                      = aws_s3_bucket.secure_s3_bucket[0].bucket
    bucket_domain_name          = aws_s3_bucket.secure_s3_bucket[0].bucket_domain_name
    bucket_regional_domain_name = aws_s3_bucket.secure_s3_bucket[0].bucket_regional_domain_name
    bucket_region               = aws_s3_bucket.secure_s3_bucket[0].bucket_region
    hosted_zone_id              = aws_s3_bucket.secure_s3_bucket[0].hosted_zone_id
    tags                        = aws_s3_bucket.secure_s3_bucket[0].tags
    tags_all                    = aws_s3_bucket.secure_s3_bucket[0].tags_all
  } : null
}

output "log_bucket" {
  description = "The S3 bucket used for storing access logs of this bucket. Stable metadata only; legacy inline configuration attributes are not exported."
  value = var.enabled && var.log_bucket_name != "" ? {
    id                          = aws_s3_bucket.access_log[0].id
    arn                         = aws_s3_bucket.access_log[0].arn
    bucket                      = aws_s3_bucket.access_log[0].bucket
    bucket_domain_name          = aws_s3_bucket.access_log[0].bucket_domain_name
    bucket_regional_domain_name = aws_s3_bucket.access_log[0].bucket_regional_domain_name
    bucket_region               = aws_s3_bucket.access_log[0].bucket_region
    hosted_zone_id              = aws_s3_bucket.access_log[0].hosted_zone_id
    tags                        = aws_s3_bucket.access_log[0].tags
    tags_all                    = aws_s3_bucket.access_log[0].tags_all
  } : null
}
