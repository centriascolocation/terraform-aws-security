mock_provider "aws" {
  mock_data "aws_iam_policy_document" {
    defaults = { json = "{\"Version\":\"2012-10-17\",\"Statement\":[]}" }
  }
  mock_data "aws_caller_identity" {
    defaults = { account_id = "111111111111" }
  }
  mock_data "aws_region" {
    defaults = { region = "eu-central-1" }
  }
  mock_data "aws_partition" {
    defaults = { partition = "aws" }
  }
  mock_data "aws_organizations_organization" {
    defaults = { id = "o-example", master_account_id = "222222222222" }
  }
}
variables {
  bucket_name = "baseline-cloudtrail-test"
  trail_name  = "baseline"
}
run "standalone" {
  command = plan
  assert {
    condition     = length(data.aws_organizations_organization.organization) == 0 && local.trail_account_id == "111111111111"
    error_message = "Standalone trails must not query Organizations."
  }
  assert {
    condition     = length(local.delivery_paths) == 1 && local.delivery_paths[0] == "arn:aws:s3:::baseline-cloudtrail-test/AWSLogs/111111111111/*"
    error_message = "Standalone delivery must use the caller account."
  }
  assert {
    condition     = length(aws_s3_bucket_policy.this) == 1 && length(data.aws_iam_policy_document.bucket_policy.statement) == 3
    error_message = "One policy must contain TLS deny and both delivery statements."
  }
  assert {
    condition = alltrue([for s in data.aws_iam_policy_document.bucket_policy.statement :
      s.effect != "Allow" || anytrue([for c in s.condition : c.variable == "aws:SourceArn" && contains(c.values, local.trail_arn)])
    ])
    error_message = "Every service permission must be scoped to the trail ARN."
  }
}
run "organization" {
  command = plan
  variables { is_organization_trail = true }
  assert {
    condition     = length(data.aws_organizations_organization.organization) == 1 && local.trail_account_id == "222222222222" && length(local.delivery_paths) == 2
    error_message = "Organization trails need management-account and organization delivery paths."
  }
  assert {
    condition     = local.trail_arn == "arn:aws:cloudtrail:eu-central-1:222222222222:trail/baseline" && contains(local.delivery_paths, "arn:aws:s3:::baseline-cloudtrail-test/AWSLogs/o-example/*")
    error_message = "Organization source ARN must use the management account."
  }
}
run "external_policy_owner" {
  command = plan
  variables { manage_bucket_policy = false }
  assert {
    condition     = length(aws_s3_bucket_policy.this) == 0
    error_message = "External ownership must not create a second bucket policy."
  }
}
run "partition" {
  command = plan
  override_data {
    target = data.aws_partition.current
    values = { partition = "aws-us-gov" }
  }
  assert {
    condition     = local.trail_arn == "arn:aws-us-gov:cloudtrail:eu-central-1:111111111111:trail/baseline" && local.bucket_arn == "arn:aws-us-gov:s3:::baseline-cloudtrail-test"
    error_message = "Policy ARNs must use the provider partition."
  }
}

run "encrypted_cloudwatch_delivery" {
  command = plan
  variables {
    kms_key_id                 = "arn:aws:kms:eu-central-1:111111111111:key/11111111-1111-1111-1111-111111111111"
    cloud_watch_logs_group_arn = "arn:aws:logs:eu-central-1:111111111111:log-group:baseline:*"
    cloud_watch_logs_role_arn  = "arn:aws:iam::111111111111:role/cloudtrail-logs"
  }
  assert {
    condition     = output.kms_key_id == var.kms_key_id && output.cloud_watch_logs_role_arn == var.cloud_watch_logs_role_arn && aws_cloudtrail.this.cloud_watch_logs_group_arn == var.cloud_watch_logs_group_arn
    error_message = "CloudTrail must preserve explicitly configured KMS and CloudWatch delivery."
  }
}
