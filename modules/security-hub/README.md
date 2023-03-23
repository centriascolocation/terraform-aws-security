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
| [aws_securityhub_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |
| [aws_securityhub_standards_subscription.aws_foundational](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |
| [aws_securityhub_standards_subscription.cis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |
| [aws_securityhub_standards_subscription.pci_dss](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_aws_foundational_standard"></a> [enable\_aws\_foundational\_standard](#input\_enable\_aws\_foundational\_standard) | Whether to enable AWS Foundations standard | `bool` | `true` | no |
| <a name="input_enable_cis_standard"></a> [enable\_cis\_standard](#input\_enable\_cis\_standard) | Whether to enable CIS standard | `bool` | `false` | no |
| <a name="input_enable_pci_dss_standard"></a> [enable\_pci\_dss\_standard](#input\_enable\_pci\_dss\_standard) | Whether to enable PCI DSS standard | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false will not enable Security Hub at all | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_hub_id"></a> [security\_hub\_id](#output\_security\_hub\_id) | Security Hub Id |
