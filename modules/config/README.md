# config

Upgrade from 1.x: [v2 migration guide](../../UPGRADING.md).

## Recorder configuration

Set `aws_account_id` to the actual delivery account. Select all supported resources
or a non-empty `resource_types` set. Global IAM recording should be enabled in
only one supported Region per account. `recording_frequency` controls recording;
`config_delivery_frequency` separately controls snapshot delivery.

`recorder_role_arn` optionally selects an existing role such as the Config
service-linked role. The original custom role remains managed to preserve state.
The bucket policy denies non-TLS access and scopes service delivery to the account.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.30 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.30 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_config_configuration_recorder.config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder) | resource |
| [aws_config_configuration_recorder_status.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder_status) | resource |
| [aws_config_delivery_channel.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_delivery_channel) | resource |
| [aws_iam_role.config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.config_lc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_ownership_controls.config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.config_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.config_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.config_sse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.config_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [time_sleep.wait_for_bucket_created](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | corresponding number of aws account | `string` | `""` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | values for additional tags | `map(string)` | <pre>{<br/>  "Generator": "Terraform",<br/>  "Module": "aws.terraform.modules.config"<br/>}</pre> | no |
| <a name="input_config_bucket_key_prefix"></a> [config\_bucket\_key\_prefix](#input\_config\_bucket\_key\_prefix) | Prefix name for config objects in bucket | `string` | `"config"` | no |
| <a name="input_config_bucket_name_prefix"></a> [config\_bucket\_name\_prefix](#input\_config\_bucket\_name\_prefix) | Prefix name for config bucket | `string` | `"config-"` | no |
| <a name="input_config_delivery_frequency"></a> [config\_delivery\_frequency](#input\_config\_delivery\_frequency) | The frequency with which AWS Config delivers configuration snapshots. | `string` | `"Six_Hours"` | no |
| <a name="input_config_name"></a> [config\_name](#input\_config\_name) | The name for the corresponding config resources | `string` | `""` | no |
| <a name="input_include_global_resource_types"></a> [include\_global\_resource\_types](#input\_include\_global\_resource\_types) | Include global IAM resources; enable in only one supported Region per account. | `bool` | `true` | no |
| <a name="input_record_all_supported_resources"></a> [record\_all\_supported\_resources](#input\_record\_all\_supported\_resources) | Record all supported resource types; false selects resource\_types. | `bool` | `true` | no |
| <a name="input_recorder_role_arn"></a> [recorder\_role\_arn](#input\_recorder\_role\_arn) | Recorder role override. The legacy custom role remains managed to avoid deleting it during migration. | `string` | `null` | no |
| <a name="input_recording_frequency"></a> [recording\_frequency](#input\_recording\_frequency) | Configuration recording frequency, independent of snapshot delivery. | `string` | `"CONTINUOUS"` | no |
| <a name="input_resource_types"></a> [resource\_types](#input\_resource\_types) | Explicit resource types when record\_all\_supported\_resources is false. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_config_configuration_recorder_id"></a> [aws\_config\_configuration\_recorder\_id](#output\_aws\_config\_configuration\_recorder\_id) | Configuration of created config recorder resource |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | n/a |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | n/a |
| <a name="output_bucket_policy_statements"></a> [bucket\_policy\_statements](#output\_bucket\_policy\_statements) | n/a |
| <a name="output_recorder_role_arn"></a> [recorder\_role\_arn](#output\_recorder\_role\_arn) | n/a |

<!-- END_TF_DOCS -->
