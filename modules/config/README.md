## Requirements

| Name | Version  |
|------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13  |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0   |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.7.1 |

## Providers

| Name | Version  |
|------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0   |
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
| [aws_s3_bucket_policy.config_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.config_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [time_sleep.wait_for_bucket_created](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | corresponding number of aws account | `string` | `""` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | values for additional tags | `map(string)` | <pre>{<br>  "Generator": "Terraform",<br>  "Module": "aws.terraform.modules.config"<br>}</pre> | no |
| <a name="input_config_bucket_key_prefix"></a> [config\_bucket\_key\_prefix](#input\_config\_bucket\_key\_prefix) | Prefix name for config objects in bucket | `string` | `"config"` | no |
| <a name="input_config_bucket_name_prefix"></a> [config\_bucket\_name\_prefix](#input\_config\_bucket\_name\_prefix) | Prefix name for config bucket | `string` | `"config-"` | no |
| <a name="input_config_delivery_frequency"></a> [config\_delivery\_frequency](#input\_config\_delivery\_frequency) | The frequency with which AWS Config delivers configuration snapshots. | `string` | `"Six_Hours"` | no |
| <a name="input_config_name"></a> [config\_name](#input\_config\_name) | The name for the corresponding config resources | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_config_configuration_recorder_id"></a> [aws\_config\_configuration\_recorder\_id](#output\_aws\_config\_configuration\_recorder\_id) | Configuration of created config recorder resource |
