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
| [aws_accessanalyzer_analyzer.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/accessanalyzer_analyzer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_analyzer_name"></a> [analyzer\_name](#input\_analyzer\_name) | Name for the IAM Access Analyzer | `string` | `"default-analyzer"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false will not create an Analyzer | `bool` | `true` | no |
| <a name="input_is_organization"></a> [is\_organization](#input\_is\_organization) | Set this to true if the IAM Access Analyzer should be enabled in an Organization Master Account | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Add these tags to all resources created by this module | `map(any)` | <pre>{<br>  "Generator": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
