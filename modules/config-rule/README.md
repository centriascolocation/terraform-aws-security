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
| [aws_config_config_rule.config_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_config_configuration_recorder_id"></a> [aws\_config\_configuration\_recorder\_id](#input\_aws\_config\_configuration\_recorder\_id) | Configuration of config recorder resource | `string` | `""` | no |
| <a name="input_config_rules"></a> [config\_rules](#input\_config\_rules) | A list of config rules | `map(any)` | <pre>{<br>  "EC2_SECURITY_GROUP_ATTACHED_TO_ENI": {<br>    "name": "ec2-security-group-attached-to-eni",<br>    "scope": {<br>      "compliance_resource_types": [<br>        "AWS::EC2::SecurityGroup"<br>      ]<br>    },<br>    "source": {<br>      "owner": "AWS",<br>      "source_identifier": "EC2_SECURITY_GROUP_ATTACHED_TO_ENI"<br>    }<br>  },<br>  "IAM_ROOT_ACCESS_KEY_CHECK": {<br>    "name": "iam-root-access-key-check",<br>    "scope": {<br>      "compliance_resource_types": []<br>    },<br>    "source": {<br>      "owner": "AWS",<br>      "source_identifier": "IAM_ROOT_ACCESS_KEY_CHECK"<br>    }<br>  },<br>  "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS": {<br>    "name": "mfa-enabled-for-iam-console-access",<br>    "scope": {<br>      "compliance_resource_types": []<br>    },<br>    "source": {<br>      "owner": "AWS",<br>      "source_identifier": "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"<br>    }<br>  },<br>  "cloud_trail_enabled": {<br>    "name": "cloud-trail-enabled",<br>    "scope": {<br>      "compliance_resource_types": []<br>    },<br>    "source": {<br>      "owner": "AWS",<br>      "source_identifier": "CLOUD_TRAIL_ENABLED"<br>    }<br>  },<br>  "incoming_ssh_disabled": {<br>    "name": "incoming-ssh-disabled",<br>    "scope": {<br>      "compliance_resource_types": [<br>        "AWS::EC2::SecurityGroup"<br>      ]<br>    },<br>    "source": {<br>      "owner": "AWS",<br>      "source_identifier": "INCOMING_SSH_DISABLED"<br>    }<br>  },<br>  "root_account_mfa_enabled": {<br>    "name": "root-account-mfa-enabled",<br>    "scope": {<br>      "compliance_resource_types": []<br>    },<br>    "source": {<br>      "owner": "AWS",<br>      "source_identifier": "ROOT_ACCOUNT_MFA_ENABLED"<br>    }<br>  }<br>}</pre> | no |

## Outputs

No outputs.
