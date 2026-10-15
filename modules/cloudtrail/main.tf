data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "this" {
  name                       = var.trail_name
  s3_bucket_name             = var.bucket_name
  is_organization_trail      = var.is_organization_trail
  kms_key_id                 = var.kms_key_id
  cloud_watch_logs_group_arn = var.cloud_watch_logs_group_arn
  cloud_watch_logs_role_arn  = var.cloud_watch_logs_role_arn

  # some immutable defaults:
  is_multi_region_trail         = true
  include_global_service_events = true
  enable_log_file_validation    = true

  tags = merge(
    var.tags,
    {
      "Name" = var.bucket_name
    },
  )

  depends_on = [
    aws_s3_bucket_policy.this,
    var.cloudtrail_depends_on
  ]
}
