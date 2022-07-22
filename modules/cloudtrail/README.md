## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0  |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0  |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.account_only_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.organizations_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the S3 bucket (3 - 63 characters long) | `string` | n/a | yes |
| <a name="input_cloudtrail_depends_on"></a> [cloudtrail\_depends\_on](#input\_cloudtrail\_depends\_on) | External resources which should be set up before CloudTrail, e.g. the Secure S3 Bucket | `list(any)` | `[]` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | Whether this is an Organizational Trail | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Add these tags to all resources created by this module | `map(any)` | <pre>{<br>  "Generator": "Terraform"<br>}</pre> | no |
| <a name="input_trail_name"></a> [trail\_name](#input\_trail\_name) | The name of the Trail | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_s3_bucket_name"></a> [this\_s3\_bucket\_name](#output\_this\_s3\_bucket\_name) | The S3 Bucketname which stores the CloudTrail logs |
| <a name="output_this_trail_name"></a> [this\_trail\_name](#output\_this\_trail\_name) | The name of the CloudTrail |
