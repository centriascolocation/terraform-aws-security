## Requirements

The following requirements are needed by this module:

- terraform (>= 0.13)

- aws (~> 3.0)

## Providers

The following providers are used by this module:

- aws (~> 3.0)

## Required Inputs

No required input.

## Optional Inputs

The following input variables are optional (have default values):

### aws\_config\_configuration\_recorder\_id

Description: Configuration of config recorder resource

Type: `string`

Default: `""`

### config\_rules

Description: A list of config rules

Type: `map(any)`

Default:

```json
{
  "EC2_SECURITY_GROUP_ATTACHED_TO_ENI": {
    "name": "ec2-security-group-attached-to-eni",
    "scope": {
      "compliance_resource_types": [
        "AWS::EC2::SecurityGroup"
      ]
    },
    "source": {
      "owner": "AWS",
      "source_identifier": "EC2_SECURITY_GROUP_ATTACHED_TO_ENI"
    }
  },
  "IAM_ROOT_ACCESS_KEY_CHECK": {
    "name": "iam-root-access-key-check",
    "scope": {
      "compliance_resource_types": []
    },
    "source": {
      "owner": "AWS",
      "source_identifier": "IAM_ROOT_ACCESS_KEY_CHECK"
    }
  },
  "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS": {
    "name": "mfa-enabled-for-iam-console-access",
    "scope": {
      "compliance_resource_types": []
    },
    "source": {
      "owner": "AWS",
      "source_identifier": "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
    }
  },
  "cloud_trail_enabled": {
    "name": "cloud-trail-enabled",
    "scope": {
      "compliance_resource_types": []
    },
    "source": {
      "owner": "AWS",
      "source_identifier": "CLOUD_TRAIL_ENABLED"
    }
  },
  "incoming_ssh_disabled": {
    "name": "incoming-ssh-disabled",
    "scope": {
      "compliance_resource_types": [
        "AWS::EC2::SecurityGroup"
      ]
    },
    "source": {
      "owner": "AWS",
      "source_identifier": "INCOMING_SSH_DISABLED"
    }
  },
  "root_account_mfa_enabled": {
    "name": "root-account-mfa-enabled",
    "scope": {
      "compliance_resource_types": []
    },
    "source": {
      "owner": "AWS",
      "source_identifier": "ROOT_ACCOUNT_MFA_ENABLED"
    }
  }
}
```

## Outputs

No output.
