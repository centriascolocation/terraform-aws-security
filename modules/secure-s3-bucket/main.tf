data "aws_iam_policy_document" "access_log_policy" {
  count = var.log_bucket_name != "" ? 1 : 0

  statement {
    actions = ["s3:*"]
    effect  = "Deny"
    resources = [
      aws_s3_bucket.access_log[0].arn,
      "${aws_s3_bucket.access_log[0].arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket" "access_log" {
  count = var.log_bucket_name != "" ? 1 : 0

  bucket = var.log_bucket_name

  acl = "log-delivery-write"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  force_destroy = var.force_destroy

  lifecycle_rule {
    id      = "auto-archive"
    enabled = true

    prefix = "/"

    dynamic "transition" {
      for_each = length(keys(var.lifecycle_rule_current_version)) == 0 ? [] : [
      var.lifecycle_rule_current_version]

      content {
        days          = transition.value.days
        storage_class = transition.value.storage_class
      }
    }
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.log_bucket_name
    }
  )
}

resource "aws_s3_bucket_policy" "access_log_policy" {
  count = var.log_bucket_name != "" ? 1 : 0

  bucket = aws_s3_bucket.access_log[0].id
  policy = data.aws_iam_policy_document.access_log_policy[0].json
}

resource "time_sleep" "wait_for_access_log_bucket" {
  depends_on      = [aws_s3_bucket.access_log]
  create_duration = "5s"
}

resource "aws_s3_bucket_public_access_block" "access_log" {
  count = var.log_bucket_name != "" ? 1 : 0

  bucket = aws_s3_bucket.access_log[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [time_sleep.wait_for_access_log_bucket]
}

resource "aws_s3_bucket" "secure_s3_bucket" {
  count = var.enabled ? 1 : 0

  bucket = var.bucket_name

  acl           = "private"
  force_destroy = var.force_destroy

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  dynamic "logging" {
    for_each = length(keys(var.logging)) == 0 ? [] : [var.logging]

    content {
      target_bucket = logging.value.target_bucket
      target_prefix = lookup(logging.value, "target_prefix", null)
    }
  }

  versioning {
    enabled    = var.enable_versioning
    mfa_delete = var.mfa_delete
  }

  lifecycle_rule {
    id      = "auto-archive"
    enabled = true
    prefix  = "/"

    dynamic "transition" {
      for_each = length(keys(var.lifecycle_rule_current_version)) == 0 ? [] : [
      var.lifecycle_rule_current_version]

      content {
        days          = transition.value.days
        storage_class = transition.value.storage_class
      }
    }
    dynamic "noncurrent_version_transition" {
      for_each = length(keys(var.lifecycle_rule_noncurrent_version)) == 0 ? [] : [
      var.lifecycle_rule_noncurrent_version]

      content {
        days          = noncurrent_version_transition.value.days
        storage_class = noncurrent_version_transition.value.storage_class
      }
    }
    expiration {
      date                         = var.lifecycle_rule_expiration.date
      days                         = var.lifecycle_rule_expiration.days
      expired_object_delete_marker = var.lifecycle_rule_expiration.expired_object_delete_marker
    }
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.bucket_name
    }
  )
}

resource "time_sleep" "wait_for_secure_s3_bucket" {
  depends_on      = [aws_s3_bucket.secure_s3_bucket]
  create_duration = "5s"
}

resource "aws_s3_bucket_public_access_block" "secure_s3_bucket" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.secure_s3_bucket[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [time_sleep.wait_for_secure_s3_bucket]
}

resource "aws_s3_bucket_policy" "secure_s3_bucket" {
  bucket = aws_s3_bucket.secure_s3_bucket[0].id
  policy = data.aws_iam_policy_document.secure_s3_bucket.json
}

data "aws_iam_policy_document" "secure_s3_bucket" {
  statement {
    sid    = "AllowSSLRequestsOnly"
    effect = "Deny"

    resources = [
      aws_s3_bucket.secure_s3_bucket[0].arn,
      "${aws_s3_bucket.secure_s3_bucket[0].arn}/*",
    ]

    actions = [
    "s3:*"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
      "false"]
    }

    principals {
      type = "*"
      identifiers = [
      "*"]
    }
  }
}
