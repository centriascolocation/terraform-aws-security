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

### analyzer\_name

Description: Name for the IAM Access Analyzer

Type: `string`

Default: `"default-analyzer"`

### enabled

Description: Set to false will not create an Analyzer

Type: `bool`

Default: `true`

### is\_organization

Description: Set this to true if the IAM Access Analyzer should be enabled in an Organization Master Account

Type: `bool`

Default: `false`

### tags

Description: Add these tags to all resources created by this module

Type: `map`

Default:

```json
{
  "Generator": "Terraform"
}
```

## Outputs

No output.
