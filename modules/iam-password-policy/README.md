## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_account_password_policy.iam_account_password_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_users_to_change_password"></a> [allow\_users\_to\_change\_password](#input\_allow\_users\_to\_change\_password) | Allow users to change their passwords | `bool` | `true` | no |
| <a name="input_max_password_age"></a> [max\_password\_age](#input\_max\_password\_age) | The number of days that an user password is valid | `number` | `90` | no |
| <a name="input_minimum_password_length"></a> [minimum\_password\_length](#input\_minimum\_password\_length) | Minimum password length | `number` | `20` | no |
| <a name="input_password_reuse_prevention"></a> [password\_reuse\_prevention](#input\_password\_reuse\_prevention) | The number of previous passwords that users are prevented from reusing | `number` | `5` | no |
| <a name="input_require_lowercase_characters"></a> [require\_lowercase\_characters](#input\_require\_lowercase\_characters) | Whether lowercase chars are required | `bool` | `true` | no |
| <a name="input_require_numbers"></a> [require\_numbers](#input\_require\_numbers) | Whether numbers are required | `bool` | `true` | no |
| <a name="input_require_symbols"></a> [require\_symbols](#input\_require\_symbols) | Whether symbos are required | `bool` | `true` | no |
| <a name="input_require_uppercase_characters"></a> [require\_uppercase\_characters](#input\_require\_uppercase\_characters) | Whether uppercase chars are required | `bool` | `true` | no |

## Outputs

No outputs.
