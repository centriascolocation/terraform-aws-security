data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_policy" "this" {
  bucket     = var.bucket_name
  depends_on = [var.bucket_name]
  policy     = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailGetBucketAcl",
            "Effect": "Allow",
            "Principal": {"Service": "cloudtrail.amazonaws.com"},
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.bucket_name}"
        },
        {
            "Sid": "AWSCloudTrailPutObject",
            "Effect": "Allow",
            "Principal": {"Service": "cloudtrail.amazonaws.com"},
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {"StringEquals": {"s3:x-amz-acl": "bucket-owner-full-control"}}
        }
    ]
}
POLICY
}

resource "aws_cloudtrail" "this" {
  name                  = var.trail_name
  s3_bucket_name        = var.bucket_name
  is_organization_trail = var.is_organization_trail

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
