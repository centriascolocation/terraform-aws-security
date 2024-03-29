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

Terraform Version 0.13 or newer is required.

## Usage

Since there is no root module, check the included submodules.

_Hint_: Omit the version attribute to use the most recent `master` branch.

In general, to just get started, create a Terraform file (e.g.: `security-example.tf`) with the following content:

```hcl
  module "security" {
    source  = "centriascolocation/security/aws"
    version = "~> 1.4"
  }
```

Example of using one module:

```hcl
  module "security_iam-access-analyzer" {
    source  = "centriascolocation/security/aws//modules/iam-access-analyzer"
    version = "~> 1.4"
  }
```

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

## Further Information

### Authors

  * Michael Krieg <michael@centrias.de>
  * Volker Bohne <bohne@centrias.de>
  * Christian Weirich <christian@centrias.de>
  * Dirk Piethan <dirk@centrias.de>
  * Jonas Ueberschaer <jonas@centrias.de>

### License

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.
