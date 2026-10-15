data "aws_partition" "current" {}
data "aws_region" "current" {}
data "aws_organizations_organization" "organization" {
  count                    = var.is_organization_trail ? 1 : 0
  return_organization_only = true
}

locals {
  trail_account_id = var.is_organization_trail ? data.aws_organizations_organization.organization[0].master_account_id : data.aws_caller_identity.current.account_id
  bucket_arn       = "arn:${data.aws_partition.current.partition}:s3:::${var.bucket_name}"
  trail_arn        = "arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.region}:${local.trail_account_id}:trail/${var.trail_name}"
  delivery_paths = concat(
    ["${local.bucket_arn}/AWSLogs/${local.trail_account_id}/*"],
    var.is_organization_trail ? ["${local.bucket_arn}/AWSLogs/${data.aws_organizations_organization.organization[0].id}/*"] : []
  )
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.manage_bucket_policy ? 1 : 0
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.bucket_policy.json
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid       = "AllowSSLRequestsOnly"
    effect    = "Deny"
    actions   = ["s3:*"]
    resources = [local.bucket_arn, "${local.bucket_arn}/*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  statement {
    sid       = "AWSCloudTrailGetBucketAcl"
    effect    = "Allow"
    actions   = ["s3:GetBucketAcl"]
    resources = [local.bucket_arn]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [local.trail_arn]
    }
  }

  statement {
    sid       = "AWSCloudTrailPutObject"
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = local.delivery_paths
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [local.trail_arn]
    }
  }
}
