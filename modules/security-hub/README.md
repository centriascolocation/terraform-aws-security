## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable\_aws\_foundational\_standard | Whether to enable AWS Foundations standard | `bool` | `true` | no |
| enable\_cis\_standard | Whether to enable CIS standard | `bool` | `false` | no |
| enable\_pci\_dss\_standard | Whether to enable PCI DSS standard | `bool` | `false` | no |
| enabled | Set to false will not enable Security Hub at all | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| security\_hub\_id | Security Hub Id |
