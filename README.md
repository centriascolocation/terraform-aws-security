<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Terraform AWS Security](#terraform-aws-security)
    - [Batteries (aka: modules) included](#batteries-aka-modules-included)
    - [Requirements](#requirements)
    - [Usage](#usage)
        - [Usage (private access to gitlab.com via SSH)](#usage-private-access-to-gitlabcom-via-ssh)
        - [Local Development](#local-development)
    - [Further Information](#further-information)
        - [Authors](#authors)
        - [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

[![pipeline status master branch](https://gitlab.com/centrias/terraform-modules/terraform-aws-security/badges/master/pipeline.svg)](https://gitlab.com/centrias/terraform-modules/terraform-aws-security/-/commits/master)

# Terraform AWS Security

This collection of reusable Terraform Modules aims to help with the following recurring topics:

  * AWS Secure Baselining:
    * CloudTrail
    * IAM
    * Config
    * Security Hub
    * Secure S3 Buckets (encrypted, versioned, optional access logging)
    * EBS Volume Encryption

## Batteries (aka: modules) included

  * [iam-access-analyzer](modules/iam-access-analyzer/README.md)
  * [iam-password-policy](modules/iam-password-policy/README.md)
  * [secure-s3-bucket](modules/secure-s3-bucket/README.md)
  * [ebs-default-encryption](modules/ebs-default-encryption/README.md)

## Requirements

Terraform Version 0.13 is required. It is recommended to use [pre-commit](https://pre-commit.com/) and its friends.

## Usage

> Public access is planned in future, but not yet available.

### Usage (private access to gitlab.com via SSH)

See [Examples](examples/README.md) for further instructions.

### Local Development

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
