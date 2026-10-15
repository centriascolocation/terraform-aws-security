mock_provider "aws" {
  mock_data "aws_iam_policy_document" {
    defaults = { json = "{\"Version\":\"2012-10-17\",\"Statement\":[]}" }
  }
}
mock_provider "time" {}
run "ownership" {
  command = plan
  variables {
    aws_account_id = "111111111111"
    config_name    = "baseline-test"
  }
  assert {
    condition     = aws_s3_bucket_ownership_controls.config.rule[0].object_ownership == "BucketOwnerEnforced"
    error_message = "Config bucket must disable ACLs."
  }
}

run "continuous_defaults" {
  command = plan
  variables {
    aws_account_id = "111111111111"
    config_name    = "baseline-test"
  }
  assert {
    condition     = aws_config_configuration_recorder.config.recording_group[0].all_supported && aws_config_configuration_recorder.config.recording_group[0].include_global_resource_types && aws_config_configuration_recorder.config.recording_mode[0].recording_frequency == "CONTINUOUS"
    error_message = "Preserve continuous recording of all resources including global IAM by default."
  }
}

run "selected_resources_daily" {
  command = plan
  variables {
    aws_account_id                 = "111111111111"
    config_name                    = "baseline-test"
    record_all_supported_resources = false
    resource_types                 = ["AWS::EC2::Instance"]
    include_global_resource_types  = false
    recording_frequency            = "DAILY"
    config_delivery_frequency      = "TwentyFour_Hours"
  }
  assert {
    condition     = !aws_config_configuration_recorder.config.recording_group[0].all_supported && !aws_config_configuration_recorder.config.recording_group[0].include_global_resource_types && aws_config_configuration_recorder.config.recording_group[0].resource_types == toset(["AWS::EC2::Instance"])
    error_message = "Explicit resource selection and global IAM toggle must reach the recorder."
  }
  assert {
    condition     = aws_config_configuration_recorder.config.recording_mode[0].recording_frequency == "DAILY" && aws_config_delivery_channel.main.snapshot_delivery_properties[0].delivery_frequency == "TwentyFour_Hours"
    error_message = "Recording frequency and snapshot delivery must be independent configurable settings."
  }
}

run "external_recorder_role_preserves_custom_role" {
  command = plan
  variables {
    aws_account_id    = "111111111111"
    config_name       = "baseline-test"
    recorder_role_arn = "arn:aws:iam::111111111111:role/aws-service-role/config.amazonaws.com/AWSServiceRoleForConfig"
  }
  assert {
    condition     = output.recorder_role_arn == var.recorder_role_arn && aws_iam_role.config.name == "baseline-test"
    error_message = "An external recorder role must not remove the existing custom role."
  }
  assert {
    condition     = length(data.aws_iam_policy_document.bucket_policy.statement) == 4 && alltrue([for statement in data.aws_iam_policy_document.bucket_policy.statement : statement.effect != "Allow" || anytrue([for condition in statement.condition : condition.variable == "aws:SourceAccount" && condition.values == tolist([var.aws_account_id])])])
    error_message = "Config delivery permissions must be account-scoped and retain the TLS deny."
  }
}
