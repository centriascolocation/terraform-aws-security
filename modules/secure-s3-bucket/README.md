## Requirements

The following requirements are needed by this module:

- terraform (>= 0.13)

- aws (~> 3.0)

## Providers

The following providers are used by this module:

- aws (~> 3.0)

## Required Inputs

The following input variables are required:

### bucket\_name

Description: The name of the S3 bucket

Type: `string`

### log\_bucket\_name

Description: The name of the S3 Logging bucket

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### enabled

Description: A boolean that indicates this module is enabled. Resources are not created if it is set to false.

Type: `bool`

Default: `true`

### force\_destroy

Description: A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable.

Type: `bool`

Default: `false`

### lifecycle\_glacier\_transition\_days

Description: The number of days after object creation when the object is archived into Glacier.

Type: `number`

Default: `90`

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

The following outputs are exported:

### log\_bucket

Description: The S3 bucket used for storing access logs of this bucket.

### this\_bucket

Description: This S3 bucket.
