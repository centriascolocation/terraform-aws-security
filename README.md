<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Terraform AWS Security](#terraform-aws-security)
    - [Batteries (aka: modules) included](#batteries-aka-modules-included)
    - [Requirements](#requirements)
    - [Usage](#usage)
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

## Batteries (aka: modules) included

  * [iam-access-analyzer](modules/iam-access-analyzer/README.md)

## Requirements

Terraform Version 0.13 is required. It is recommended to use [pre-commit](https://pre-commit.com/) and its friends.

## Usage

### Local Development

Put new modules under the subdirectory `modules/`.

You'll also need:

  * terraform-docs
  * tflint
  * tfsec

## Further Information

### Authors

  * Michael Krieg <michael@centrias.de>

### License

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.
