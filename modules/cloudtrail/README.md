# cloudtrail

Upgrade from 1.x: [v2 migration guide](../../UPGRADING.md).

## Encryption and delivery

`kms_key_id`, `cloud_watch_logs_group_arn` (with trailing `:*`) and
`cloud_watch_logs_role_arn` are optional and default to `null`. Supply the KMS
key policy and IAM delivery permissions in the calling root.

Exactly one owner must manage the complete bucket policy. Set
`manage_bucket_policy = false` when composing `bucket_policy_json` externally;
install the composed policy before creating the trail. Standalone mode does not
query Organizations. Organization mode still requires appropriate account permissions.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the S3 bucket (3 - 63 characters long) | `string` | n/a | yes |
| <a name="input_cloud_watch_logs_group_arn"></a> [cloud\_watch\_logs\_group\_arn](#input\_cloud\_watch\_logs\_group\_arn) | Optional CloudWatch Logs group ARN with a trailing :*. | `string` | `null` | no |
| <a name="input_cloud_watch_logs_role_arn"></a> [cloud\_watch\_logs\_role\_arn](#input\_cloud\_watch\_logs\_role\_arn) | Optional IAM role ARN for CloudWatch Logs delivery. | `string` | `null` | no |
| <a name="input_cloudtrail_depends_on"></a> [cloudtrail\_depends\_on](#input\_cloudtrail\_depends\_on) | External resources which should be set up before CloudTrail, e.g. the Secure S3 Bucket | `list(any)` | `[]` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | Whether this is an Organizational Trail | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Optional KMS key ARN for CloudTrail log encryption. | `string` | `null` | no |
| <a name="input_manage_bucket_policy"></a> [manage\_bucket\_policy](#input\_manage\_bucket\_policy) | Manage the complete TLS and CloudTrail delivery policy. If false, install bucket\_policy\_json externally before creating the trail. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Add these tags to all resources created by this module | `map(any)` | <pre>{<br/>  "Generator": "Terraform"<br/>}</pre> | no |
| <a name="input_trail_name"></a> [trail\_name](#input\_trail\_name) | The name of the Trail | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_policy_json"></a> [bucket\_policy\_json](#output\_bucket\_policy\_json) | Complete TLS deny and CloudTrail delivery policy for an external policy owner. |
| <a name="output_cloud_watch_logs_role_arn"></a> [cloud\_watch\_logs\_role\_arn](#output\_cloud\_watch\_logs\_role\_arn) | n/a |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | n/a |
| <a name="output_this_s3_bucket_name"></a> [this\_s3\_bucket\_name](#output\_this\_s3\_bucket\_name) | The S3 Bucketname which stores the CloudTrail logs |
| <a name="output_this_trail_name"></a> [this\_trail\_name](#output\_this\_trail\_name) | The name of the CloudTrail |

<!-- END_TF_DOCS -->
