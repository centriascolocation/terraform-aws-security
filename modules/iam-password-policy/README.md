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

### allow\_users\_to\_change\_password

Description: Allow users to change their passwords

Type: `bool`

Default: `true`

### minimum\_password\_length

Description: Minimum password length

Type: `number`

Default: `20`

### password\_reuse\_prevention

Description: The number of previous passwords that users are prevented from reusing

Type: `number`

Default: `5`

### require\_lowercase\_characters

Description: Whether lowercase chars are required

Type: `bool`

Default: `true`

### require\_numbers

Description: Whether numbers are required

Type: `bool`

Default: `true`

### require\_symbols

Description: Whether symbos are required

Type: `bool`

Default: `true`

### require\_uppercase\_characters

Description: Whether uppercase chars are required

Type: `bool`

Default: `true`

## Outputs

No output.
