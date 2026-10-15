mock_provider "aws" {}
mock_provider "time" {}
variables {
  bucket_name     = "baseline-source-test"
  log_bucket_name = "baseline-access-test"
  logging         = { target_prefix = "logs/" }
}
run "ownership_and_delivery" {
  command = plan
  assert {
    condition     = aws_s3_bucket_ownership_controls.secure_s3_bucket[0].rule[0].object_ownership == "BucketOwnerEnforced" && aws_s3_bucket_ownership_controls.access_log[0].rule[0].object_ownership == "BucketOwnerEnforced"
    error_message = "Both buckets must disable ACLs."
  }
  assert {
    condition     = length(data.aws_iam_policy_document.access_log_policy[0].statement) == 2 && length(aws_s3_bucket_logging.secure_s3_bucket_logging) == 1
    error_message = "Access logging needs both TLS deny and service delivery permission."
  }
}
run "external_policy_owner" {
  command = plan
  variables { manage_bucket_policy = false }
  assert {
    condition     = length(aws_s3_bucket_policy.secure_s3_bucket) == 0 && length(aws_s3_bucket_policy.access_log_policy) == 1
    error_message = "External source policy ownership must retain the separate log bucket policy."
  }
}
run "disabled" {
  command = plan
  variables { enabled = false }
  assert {
    condition     = output.this_bucket == null && output.log_bucket == null && length(aws_s3_bucket_policy.secure_s3_bucket) == 0 && length(aws_s3_bucket.access_log) == 0
    error_message = "Disabled modules must not create buckets or policies."
  }
}

run "legacy_lifecycle_prefixes" {
  command = plan
  assert {
    condition     = one(aws_s3_bucket_lifecycle_configuration.secure_s3_bucket_lc[0].rule).filter[0].prefix == "/" && one(aws_s3_bucket_lifecycle_configuration.access_log_lc[0].rule).filter[0].prefix == "/"
    error_message = "Existing callers must retain legacy prefixes until explicitly changed."
  }
}
run "independent_lifecycle_prefixes" {
  command = plan
  variables {
    lifecycle_prefix            = "AWSLogs/"
    access_log_lifecycle_prefix = "logs/"
  }
  assert {
    condition     = one(aws_s3_bucket_lifecycle_configuration.secure_s3_bucket_lc[0].rule).filter[0].prefix == "AWSLogs/" && one(aws_s3_bucket_lifecycle_configuration.access_log_lc[0].rule).filter[0].prefix == "logs/"
    error_message = "Source and access-log prefixes must be configurable independently."
  }
}
run "all_objects_lifecycle_prefix" {
  command = plan
  variables {
    lifecycle_prefix            = ""
    access_log_lifecycle_prefix = ""
  }
  assert {
    condition     = one(aws_s3_bucket_lifecycle_configuration.secure_s3_bucket_lc[0].rule).filter[0].prefix == "" && one(aws_s3_bucket_lifecycle_configuration.access_log_lc[0].rule).filter[0].prefix == ""
    error_message = "Empty prefixes must match the whole bucket."
  }
}

run "no_expiration_by_default" {
  command = plan
  assert {
    condition     = length(one(aws_s3_bucket_lifecycle_configuration.secure_s3_bucket_lc[0].rule).expiration) == 0
    error_message = "Default null expiration settings must not emit an empty expiration block or expire objects."
  }
}

run "empty_expiration_map" {
  command = plan
  variables { lifecycle_rule_expiration = {} }
  assert {
    condition     = length(one(aws_s3_bucket_lifecycle_configuration.secure_s3_bucket_lc[0].rule).expiration) == 0
    error_message = "An empty expiration map must leave expiration disabled."
  }
}

run "expiration_after_days" {
  command = plan
  variables { lifecycle_rule_expiration = { days = 30 } }
  assert {
    condition     = one(one(aws_s3_bucket_lifecycle_configuration.secure_s3_bucket_lc[0].rule).expiration).days == 30
    error_message = "An explicit days-based expiration must be retained."
  }
}

run "expiration_on_date" {
  command = plan
  variables { lifecycle_rule_expiration = { date = "2030-01-01T00:00:00Z" } }
  assert {
    condition     = one(one(aws_s3_bucket_lifecycle_configuration.secure_s3_bucket_lc[0].rule).expiration).date == "2030-01-01T00:00:00Z"
    error_message = "An explicit date-based expiration must be retained."
  }
}

run "expired_delete_marker_cleanup" {
  command = plan
  variables { lifecycle_rule_expiration = { expired_object_delete_marker = true } }
  assert {
    condition     = one(one(aws_s3_bucket_lifecycle_configuration.secure_s3_bucket_lc[0].rule).expiration).expired_object_delete_marker
    error_message = "Explicit delete-marker cleanup must be retained."
  }
}
