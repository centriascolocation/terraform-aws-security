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

resource "aws_s3_bucket_acl" "config_acl" {
  bucket = aws_s3_bucket.config.id
  acl    = "private"
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
  name     = var.config_name
  role_arn = aws_iam_role.config.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
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

  depends_on = [aws_config_configuration_recorder.config]
}
