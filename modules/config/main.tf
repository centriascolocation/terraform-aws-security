##
## AWS Config

resource "aws_iam_role" "config" {
  name = var.config_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
  tags = merge(
    var.common_tags,
    {
      "Name" = var.config_name
    },
  )
}

resource "aws_iam_role_policy_attachment" "config" {
  role       = aws_iam_role.config.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

#we do not need accesslogging for a service like Config.
#tfsec:ignore:AWS002
resource "aws_s3_bucket" "config" {
  bucket_prefix = var.config_bucket_prefix
  acl           = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    prefix  = "${var.config_bucket_key_prefix}/"

    expiration {
      days = 365
    }

    noncurrent_version_expiration {
      days = 365
    }
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "Config Bucket"
    },
  )

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "config_bucket" {
  bucket                  = aws_s3_bucket.config.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "config_bucket_policy" {
  bucket = aws_s3_bucket.config.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSConfigBucketPermissionsCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": [
         "config.amazonaws.com"
        ]
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "${aws_s3_bucket.config.arn}"
    },
    {
      "Sid": "AWSConfigBucketExistenceCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "config.amazonaws.com"
        ]
      },
      "Action": "s3:ListBucket",
      "Resource": "${aws_s3_bucket.config.arn}"
    },
    {
      "Sid": " AWSConfigBucketDelivery",
      "Effect": "Allow",
      "Principal": {
        "Service": [
         "config.amazonaws.com"
        ]
      },
      "Action": "s3:PutObject",
      "Resource": "${aws_s3_bucket.config.arn}/${var.config_bucket_key_prefix}/AWSLogs/${var.aws_account_id}/Config/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    }
  ]
}
POLICY
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
