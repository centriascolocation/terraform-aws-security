## Requirements

The following requirements are needed by this module:

- terraform (>= 0.13)

- aws (~> 3.0)

- time (~> 0.6.0)

## Providers

The following providers are used by this module:

- aws (~> 3.0)

- time (~> 0.6.0)

## Required Inputs

No required input.

## Optional Inputs

The following input variables are optional (have default values):

### aws\_account\_id

Description: corresponding number of aws account

Type: `string`

Default: `""`

### common\_tags

Description: values for additional tags

Type: `map(string)`

Default:

```json
{
  "Generator": "Terraform",
  "Module": "aws.terraform.modules.config"
}
```

### config\_bucket\_key\_prefix

Description: Prefix name for config objects in bucket

Type: `string`

Default: `"config"`

### config\_bucket\_name\_prefix

Description: Prefix name for config bucket

Type: `string`

Default: `"config-"`

### config\_delivery\_frequency

Description: The frequency with which AWS Config delivers configuration snapshots.

Type: `string`

Default: `"Six_Hours"`

### config\_name

Description: The name for the corresponding config resources

Type: `string`

Default: `""`

## Outputs

The following outputs are exported:

### aws\_config\_configuration\_recorder\_id

Description: Configuration of created config recorder resource
