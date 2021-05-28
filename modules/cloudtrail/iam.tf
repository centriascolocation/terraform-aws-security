data "aws_organizations_organization" "organization" {}
resource "aws_s3_bucket_policy" "this" {
  bucket     = var.bucket_name
  depends_on = [var.bucket_name]
  policy     = var.is_organization_trail ? data.aws_iam_policy_document.organizations_bucket_policy.json : data.aws_iam_policy_document.account_only_bucket_policy.json
}

data "aws_iam_policy_document" "account_only_bucket_policy" {
  version = "2012-10-17"
  statement {
    sid    = "AWSCloudTrailGetBucketAcl"
    effect = "Allow"
    principals {
      identifiers = [
      "cloudtrail.amazonaws.com"]
      type = "Service"
    }
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${var.bucket_name}"]
  }

  statement {
    sid    = "AWSCloudTrailPutObject"
    effect = "Allow"
    principals {
      identifiers = [
      "cloudtrail.amazonaws.com"]
      type = "Service"
    }
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
  }
}

data "aws_iam_policy_document" "organizations_bucket_policy" {
  statement {
    sid       = "AWSCloudTrailAclCheck20150319"
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.bucket_name}"]
    actions   = ["s3:GetBucketAcl"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

  statement {
    sid       = "AWSCloudTrailWrite20150319"
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.bucket_name}/AWSLogs/${data.aws_organizations_organization.organization.master_account_id}/*"]
    actions   = ["s3:PutObject"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

  statement {
    sid       = "AWSCloudTrailWrite20150319"
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.bucket_name}/AWSLogs/${data.aws_organizations_organization.organization.id}/*"]
    actions   = ["s3:PutObject"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}
