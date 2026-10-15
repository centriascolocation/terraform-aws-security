![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/centriascolocation/terraform-aws-security)
![CI](https://github.com/centriascolocation/terraform-aws-security/workflows/CI/badge.svg)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Terraform AWS Security](#terraform-aws-security)
  - [Batteries (aka: modules) included](#batteries-aka-modules-included)
  - [Requirements](#requirements)
  - [Usage](#usage)
    - [Examples](#examples)
    - [Local Development](#local-development)
  - [Config and Security Hub: account-baseline settings](#config-and-security-hub-account-baseline-settings)
  - [Further Information](#further-information)
    - [Authors](#authors)
    - [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Terraform AWS Security

This collection of reusable Terraform Modules aims to help with the following recurring topics:

  * AWS Secure Baselining:
    * CloudTrail
    * IAM
    * Config
    * Security Hub
    * Secure S3 Buckets (encrypted, versioned, optional access logging)
    * EBS Volume Encryption enabled by default
    * IAM User Self Service Policy

## Batteries (aka: modules) included

  * [iam-access-analyzer](https://github.com/centriascolocation/terraform-aws-security/tree/master/modules/iam-access-analyzer/README.md)
  * [iam-password-policy](https://github.com/centriascolocation/terraform-aws-security/tree/master/modules/iam-password-policy/README.md)
  * [secure-s3-bucket](https://github.com/centriascolocation/terraform-aws-security/tree/master/modules/secure-s3-bucket/README.md)
  * [ebs-default-encryption](https://github.com/centriascolocation/terraform-aws-security/tree/master/modules/ebs-default-encryption/README.md)
  * [cloudtrail](https://github.com/centriascolocation/terraform-aws-security/tree/master/modules/cloudtrail/README.md)
  * [iam-userselfservice](https://github.com/centriascolocation/terraform-aws-security/tree/master/modules/iam-userselfservice/README.md)
  * [security-hub](https://github.com/centriascolocation/terraform-aws-security/tree/master/modules/security-hub/README.md)

## Requirements

For the v2 baseline modules, use Terraform >= 1.9. Combined CloudTrail / Security Hub deployments require AWS Provider >= 6.0. Config alone requires >= 5.30 and secure-S3-bucket alone requires >= 5.70. Other modules retain their declared requirements.

## Usage

Since there is no root module, check the included submodules.

Use a submodule source and pin a reviewed release. Omitting the Registry `version`
constraint selects a Registry release, not the `master` branch. There is no root
module to instantiate.

Version **2.0.0** introduces breaking changes for existing deployments. Review
the [upgrade guide](UPGRADING.md) before updating module versions. Pin a reviewed
release rather than tracking the default branch:

```hcl
module "security_iam_access_analyzer" {
  source  = "centriascolocation/security/aws//modules/iam-access-analyzer"
  version = "~> 2.0.0"
}
```

For an exact Git tag pin, use:

```hcl
module "security_iam_access_analyzer" {
  source = "git::ssh://git@github.com/centriascolocation/terraform-aws-security.git//modules/iam-access-analyzer?ref=v2.0.0"
}
```

Git sources use `ref`; do not add a Registry `version` argument to them.
Upgrading from 1.x is a breaking change: read the
[v2 migration guide](UPGRADING.md), then review the complete state-aware plan.

### Examples

The [Examples](https://github.com/centriascolocation/terraform-aws-security/tree/master/examples) folder contains some basic configurations.

### Local Development

It is recommended to use [pre-commit](https://pre-commit.com/) and its friends.

For the first time, setup pre-commit hooks like so:

```
  pre-commit install
```

Put new modules under the subdirectory `modules/`.

You'll also need:

  * terraform-docs
  * tflint
  * tfsec

## Config and Security Hub: account-baseline settings

Config now supports `record_all_supported_resources` (default `true`),
`resource_types` (default empty), `include_global_resource_types` (default `true`)
and `recording_frequency` (default `CONTINUOUS`). Snapshot delivery remains
independently controlled by `config_delivery_frequency`. Record global IAM
resources in only one supported Region per account. A reduced resource selection
must still cover the enabled Security Hub controls. AWS restricts DAILY recording
for Config's own compliance/recorder resource types.

Security Hub supports `enable_default_standards` (default `true` for compatibility).
For subscriptions exclusively managed by Terraform, explicitly set this to `false`,
keep `enable_aws_foundational_standard = true` and disable CIS/PCI. Changing this
flag does not unsubscribe standards already enabled in an existing account;
import/manage or explicitly unsubscribe those separately.

Config recording, S3 storage and Security Hub CSPM checks incur usage-based costs.
These settings do not establish a spending cap. No GuardDuty or paid additional
protection plan is enabled by these modules.

## Further Information

### Authors

  * Michael Krieg <michael@centrias.de>
  * Volker Bohne <bohne@centrias.de>
  * Christian Weirich <christian@centrias.de>
  * Dirk Piethan <dirk@centrias.de>
  * Jonas Ueberschaer <jonas@centrias.de>

### License

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.
