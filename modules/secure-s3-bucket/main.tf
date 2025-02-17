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

  force_destroy = var.force_destroy

  tags = merge(
    var.tags,
    {
      "Name" = var.log_bucket_name
    }
  )
}

resource "aws_s3_bucket_lifecycle_configuration" "access_log_lc" {
  count  = var.log_bucket_name != "" ? 1 : 0
  bucket = aws_s3_bucket.access_log[0].id

  transition_default_minimum_object_size = var.transition_default_minimum_object_size

  rule {
    id     = "auto-archive"
    status = "Enabled"

    filter {
      prefix = "/"
    }

    dynamic "transition" {
      for_each = length(keys(var.lifecycle_rule_current_version)) == 0 ? [] : [
      var.lifecycle_rule_current_version]

      content {
        days          = transition.value.days
        storage_class = transition.value.storage_class
      }
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "access_log_sse" {
  count  = var.log_bucket_name != "" ? 1 : 0
  bucket = aws_s3_bucket.access_log[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}

resource "aws_s3_bucket_acl" "access_log_acl" {
  count  = var.log_bucket_name != "" ? 1 : 0
  bucket = aws_s3_bucket.access_log[0].id

  acl = "log-delivery-write"

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


  force_destroy = var.force_destroy

  tags = merge(
    var.tags,
    {
      "Name" = var.bucket_name
    }
  )
}

resource "aws_s3_bucket_versioning" "secure_s3_bucket_versioning" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.secure_s3_bucket[0].id

  versioning_configuration {
    status     = var.enable_versioning ? "Enabled" : "Disabled"
    mfa_delete = var.mfa_delete ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "secure_s3_bucket_lc" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.secure_s3_bucket[0].id

  transition_default_minimum_object_size = var.transition_default_minimum_object_size


  rule {
    id     = "auto-archive"
    status = "Enabled"

    filter {
      prefix = "/"
    }

    dynamic "transition" {
      for_each = length(keys(var.lifecycle_rule_current_version)) == 0 ? [] : [
        var.lifecycle_rule_current_version
      ]

      content {
        days          = transition.value.days
        storage_class = transition.value.storage_class
      }
    }
    dynamic "noncurrent_version_transition" {
      for_each = length(keys(var.lifecycle_rule_noncurrent_version)) == 0 ? [] : [
        var.lifecycle_rule_noncurrent_version
      ]

      content {
        noncurrent_days = noncurrent_version_transition.value.days
        storage_class   = noncurrent_version_transition.value.storage_class
      }
    }

    expiration {
      date                         = var.lifecycle_rule_expiration.date
      days                         = var.lifecycle_rule_expiration.days
      expired_object_delete_marker = var.lifecycle_rule_expiration.expired_object_delete_marker
    }
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "secure_s3_bucket_sse" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.secure_s3_bucket[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_logging" "secure_s3_bucket_logging" {
  count  = var.enabled && length(keys(var.logging)) > 0 ? 1 : 0
  bucket = aws_s3_bucket.secure_s3_bucket[0].id

  target_bucket = aws_s3_bucket.access_log[0].id
  target_prefix = lookup(var.logging, "target_prefix", null)

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

resource "aws_s3_bucket_acl" "secure_s3_bucket_acl" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.secure_s3_bucket[0].id

  acl = "private"
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
