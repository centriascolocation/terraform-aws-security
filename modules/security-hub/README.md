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
| enabled | Set to false will not enable Security Hub at all | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| security\_hub\_id | Security Hub Id |
