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

Description: The name of the S3 bucket (3 - 63 characters long)

Type: `string`

### trail\_name

Description: The name of the Trail

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### cloudtrail\_depends\_on

Description: External resources which should be set up before CloudTrail, e.g. the Secure S3 Bucket

Type: `list`

Default: `[]`

### is\_organization\_trail

Description: Whether this is an Organizational Trail

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

The following outputs are exported:

### this\_s3\_bucket\_name

Description: The S3 Bucketname which stores the CloudTrail logs

### this\_trail\_name

Description: The name of the CloudTrail

