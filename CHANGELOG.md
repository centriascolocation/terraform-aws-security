# Change Log

All notable changes to this project will be documented in this file.

<a name="v.1.6.2"></a>
## [v1.6.2] - 2025-02-17
- the aws provider >= 5.70.0 added the argument `transition_default_minimum_object_size`
- the aws provider >= 5.86.0 added a default value `all_storage_classes_128K`

<a name="v1.5.3"></a>
## [v1.5.3] - 2021-12

- support darwin arm64 - [bug #22](https://github.com/centriascolocation/terraform-aws-security/pull/23)
- re-format terraform-docs

<a name="v1.5.2"></a>
## [v1.5.2] - 2021-06-24

- Customization For Lifecycle Rules - [#16](https://github.com/centriascolocation/terraform-aws-security/pull/16)
- MFA On Delete Enabling Flag - [#16](https://github.com/centriascolocation/terraform-aws-security/pull/16)
- Secure Transport Only Bucket Policy - [#16](https://github.com/centriascolocation/terraform-aws-security/pull/16)

<a name="v1.5.1"></a>
## [v1.5.1] - 2021-05-28

- Cloudtrail and AWS Organizations - [#15](https://github.com/centriascolocation/terraform-aws-security/pull/15)
- Update IAM User Self Service Policy - [#14](https://github.com/centriascolocation/terraform-aws-security/pull/14)

<a name="v1.5.0"></a>
## [v1.5.0] - 2021-03-31

- Creation of Access Log Bucket is now configurable (optional) - [#5](https://github.com/centriascolocation/terraform-aws-security/issues/5)
- Examples enhanced: how to use the secure-s3-bucket module

<a name="v1.4.7"></a>
## [v1.4.7] - 2021-03-17

- missing S3 Bucket Name Tag added - [#7](https://github.com/centriascolocation/terraform-aws-security/issues/7)
- wiped tfsec from github actions (will soon move to checkov)
- start validating modules one by one in CI

<a name="v1.4.6"></a>
## [v1.4.6] - 2021-02-03

- added support for the three Standard AWS Security Hub Standard Subscriptions

<a name="v1.4.5"></a>
## [v1.4.5] - 2021-01-08

- make submodules usable again (were internal in Terraform Registry)

<a name="v1.4.4"></a>
## [v1.4.4] - 2021-01-08

- added AWS Config and Security Hub Activation

<a name="v1.4.3"></a>
## [v1.4.3] - 2020-12-12

- we moved to github.com

<a name="v1.4.2"></a>
## [v1.4.2] - 2020-11-30

- examples restructured, documentation updated

<a name="v1.4.1"></a>
## [v1.4.1] - 2020-11-30

- instructions on how to use this public modules collection

<a name="v1.4.0"></a>
## [v1.4.0] - 2020-11-30

- added module: IAM User Self Service Policy

<a name="v1.3.0"></a>
## [v1.3.0] - 2020-11-25

- added module: CloudTrail

<a name="v1.2.0"></a>
## [v1.2.0] - 2020-11-23

- added module: EBS volume Encryption

<a name="v1.1.0"></a>
## [v1.1.0] - 2020-11-23

- added module: secure S3 bucket

<a name="v1.0.0"></a>
## [v1.0.0] - 2020-11-21

- added module: iam-password-policy
- added module: iam-access-analyzer
- utilize terraform-docs for each module
- initial release with QA included (Gitlab CI, pre-commit hooks)
