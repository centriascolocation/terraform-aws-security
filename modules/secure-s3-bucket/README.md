<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.70.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.70.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.access_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.secure_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.access_log_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.secure_s3_bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.access_log_lc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.secure_s3_bucket_lc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.secure_s3_bucket_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_policy.access_log_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.secure_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.access_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.secure_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.access_log_sse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.secure_s3_bucket_sse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.secure_s3_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [time_sleep.wait_for_access_log_bucket](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_for_secure_s3_bucket](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_iam_policy_document.access_log_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secure_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the S3 bucket (3 - 63 characters long) | `string` | n/a | yes |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Whether to enable versioning for the bucket | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | A boolean that indicates this module is enabled. Resources are not created if it is set to false. | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_lifecycle_rule_current_version"></a> [lifecycle\_rule\_current\_version](#input\_lifecycle\_rule\_current\_version) | change storage class after days for current objects | `map(string)` | <pre>{<br>  "days": 90,<br>  "storage_class": "GLACIER"<br>}</pre> | no |
| <a name="input_lifecycle_rule_expiration"></a> [lifecycle\_rule\_expiration](#input\_lifecycle\_rule\_expiration) | Specifies a period in the object's expire | `map(string)` | <pre>{<br>  "date": null,<br>  "days": null,<br>  "expired_object_delete_marker": null<br>}</pre> | no |
| <a name="input_lifecycle_rule_noncurrent_version"></a> [lifecycle\_rule\_noncurrent\_version](#input\_lifecycle\_rule\_noncurrent\_version) | change storage class after days for non-current objects (older versions) | `map(string)` | <pre>{<br>  "days": 90,<br>  "storage_class": "GLACIER"<br>}</pre> | no |
| <a name="input_log_bucket_name"></a> [log\_bucket\_name](#input\_log\_bucket\_name) | The name of the S3 Logging bucket (3 - 63 characters long) | `string` | `""` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Bucket Access Logging configuration. (map) | `map(string)` | `{}` | no |
| <a name="input_mfa_delete"></a> [mfa\_delete](#input\_mfa\_delete) | Forces deletion of object to identities with mfa auth. Only the bucket owner (root account) can enable MFA delete | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Add these tags to all resources created by this module | `map(any)` | <pre>{<br>  "Generator": "Terraform"<br>}</pre> | no |
| <a name="input_transition_default_minimum_object_size"></a> [transition\_default\_minimum\_object\_size](#input\_transition\_default\_minimum\_object\_size) | The default minimum object size behavior for S3 lifecycle transition. Allowed values: all\_storage\_classes\_128K, varies\_by\_storage\_class. | `string` | `"all_storage_classes_128K"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_bucket"></a> [log\_bucket](#output\_log\_bucket) | The S3 bucket used for storing access logs of this bucket. |
| <a name="output_this_bucket"></a> [this\_bucket](#output\_this\_bucket) | This S3 bucket. |
<!-- END_TF_DOCS -->
