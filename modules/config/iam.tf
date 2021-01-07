resource "aws_iam_role" "config" {
  name = var.config_name

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = merge(
    var.common_tags,
    {
      "Name" = var.config_name
    },
  )
}

data "aws_iam_policy_document" "assume_role_policy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["config.amazonaws.com"]
      type        = "Service"
    }
    effect = "Allow"
    sid    = ""
  }
}

resource "aws_s3_bucket_policy" "config_bucket_policy" {
  bucket     = aws_s3_bucket.config.id
  depends_on = [time_sleep.wait_for_bucket_created]

  policy = data.aws_iam_policy_document.bucket_policy.json
}

data "aws_iam_policy_document" "bucket_policy" {
  version = "2012-10-17"
  statement {
    sid    = "AWSConfigBucketPermissionsCheck"
    effect = "Allow"
    principals {
      identifiers = ["config.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.config.arn]
  }

  statement {
    sid    = "AWSConfigBucketExistenceCheck"
    effect = "Allow"
    principals {
      identifiers = ["config.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.config.arn]
  }

  statement {
    sid    = "AWSConfigBucketDelivery"
    effect = "Allow"
    principals {
      identifiers = ["config.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.config.arn}/${var.config_bucket_key_prefix}/AWSLogs/${var.aws_account_id}/Config/*", ]
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
  }
}
