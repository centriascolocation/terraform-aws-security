## Requirements

The following requirements are needed by this module:

- terraform (>= 0.13)

- aws (~> 3.0)

## Providers

The following providers are used by this module:

- aws (~> 3.0)

## Required Inputs

The following input variables are required:

### policy\_description

Description: Description of the IAM Policy

Type: `string`

### policy\_name

Description: Name of the IAM Policy

Type: `string`

## Optional Inputs

No optional input.

## Outputs

The following outputs are exported:

### this\_policy\_arn

Description: the Policy ARN

### this\_policy\_name

Description: the Policy Name
