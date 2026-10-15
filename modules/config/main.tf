##
## AWS Config

resource "aws_iam_role_policy_attachment" "config" {
  role       = aws_iam_role.config.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

#we do not need accesslogging for a service like Config.
#tfsec:ignore:AWS002
resource "aws_s3_bucket" "config" {
  bucket_prefix = var.config_bucket_name_prefix

  tags = merge(
    var.common_tags,
    {
      "Name" = "Config Bucket"
    },
  )
}

resource "aws_s3_bucket_ownership_controls" "config" {
  bucket = aws_s3_bucket.config.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "config_versioning" {
  bucket = aws_s3_bucket.config.id

  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "config_lc" {
  bucket = aws_s3_bucket.config.id

  rule {
    id     = "Config_LifeCycle"
    status = "Enabled"

    filter {
      prefix = "${var.config_bucket_key_prefix}/"
    }

    expiration {
      days = 365
    }

    noncurrent_version_expiration {
      noncurrent_days = 365
    }
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "config_sse" {
  bucket = aws_s3_bucket.config.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "time_sleep" "wait_for_bucket_created" {
  depends_on      = [aws_s3_bucket.config]
  create_duration = "5s"
}

resource "aws_s3_bucket_public_access_block" "config_bucket" {
  bucket                  = aws_s3_bucket.config.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on              = [time_sleep.wait_for_bucket_created]
}

resource "aws_config_configuration_recorder" "config" {
  lifecycle {
    precondition {
      condition     = var.record_all_supported_resources ? length(var.resource_types) == 0 : length(var.resource_types) > 0
      error_message = "Use either all supported resources with an empty resource_types set, or an explicit non-empty selection."
    }
  }
  name     = var.config_name
  role_arn = var.recorder_role_arn == null ? aws_iam_role.config.arn : var.recorder_role_arn

  recording_mode {
    recording_frequency = var.recording_frequency
  }

  recording_group {
    all_supported                 = var.record_all_supported_resources
    include_global_resource_types = var.include_global_resource_types
    resource_types                = var.record_all_supported_resources ? null : var.resource_types
  }
}

resource "aws_config_configuration_recorder_status" "main" {
  name       = var.config_name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.main]
}

resource "aws_config_delivery_channel" "main" {
  name           = var.config_name
  s3_bucket_name = aws_s3_bucket.config.bucket
  s3_key_prefix  = var.config_bucket_key_prefix

  snapshot_delivery_properties {
    delivery_frequency = var.config_delivery_frequency
  }

  depends_on = [aws_config_configuration_recorder.config, aws_iam_role_policy_attachment.config, aws_s3_bucket_policy.config_bucket_policy, aws_s3_bucket_public_access_block.config_bucket, aws_s3_bucket_server_side_encryption_configuration.config_sse]
}
