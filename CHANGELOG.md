# Change Log

All notable changes to this project are documented in English.

## Unreleased — planned v2.0.0

### Breaking changes

- Require Terraform >= 1.9 for CloudTrail, Config, Security Hub and secure-S3-bucket.
- Require AWS Provider >= 6.0 for CloudTrail and Security Hub. Config requires
  >= 5.30 and secure-S3-bucket requires >= 5.70; combined deployments require >= 6.0.
- Replace managed S3 ACLs with `BucketOwnerEnforced` for source, access-log and
  Config buckets. Migrate ACL-based access before upgrading existing buckets.
- Add counted addresses to bucket-policy and wait resources. Existing state needs
  the reviewed address migration described in the upgrade guide.
- Return explicit metadata from `this_bucket` and `log_bucket` instead of complete
  provider resource objects. Consumers of removed inline attributes must migrate.
- Make `enabled = false` disable access-log resources as well as source resources.
  Existing deployments relying on the former behavior may plan deletions.
- Enforce TLS and scope CloudTrail delivery to the configured trail ARN. Shared
  buckets must have one complete policy owner retaining every required statement.
- Scope Config service delivery to the configured `aws_account_id` and enforce TLS.
  Supply the actual account ID when upgrading; empty/default IDs cannot authorize delivery.

### Added

- Explicit source and access-log lifecycle-prefix inputs; both retain the legacy `/` default.
- `manage_bucket_policy` and CloudTrail `bucket_policy_json` for single-owner policies.
- Optional CloudTrail KMS and CloudWatch Logs delivery settings and verification outputs.
- Config recorder-role override and bucket/recorder/policy outputs, preserving the
  existing managed custom role when an external recorder role is selected.
- Config resource selection, global-IAM recording and recording-frequency settings.
- Security Hub automatic-standard control and configurable subscription-create timeout.
- Mock-plan regression tests and a CI matrix for Terraform 1.9.8 and 1.15.0.

### Fixed

- Use Node.js 24 action runtimes and pin CI to Ubuntu 24.04 to avoid runner-image drift.
- Omit empty S3 lifecycle expiration blocks when no expiration option is configured; retain explicit days, date and delete-marker settings.

- Avoid Organizations lookups for standalone CloudTrail deployments.
- Authorize S3 access-log delivery using a source-account/source-bucket-scoped policy.
- Order Config delivery-channel creation after its policies and encryption configuration.
- Use partition-aware CloudTrail and Security Hub ARNs.

### Upgrade and validation

Read [the v2 upgrade guide](UPGRADING.md) before applying.
Lifecycle prefixes are opt-in: broadening a prefix can activate existing expiry
or archival actions. Existing resource addresses must be preserved or explicitly
migrated; do not apply policy deletion as a substitute for a state migration.
Mock tests do not prove AWS log delivery, Organizations support or a safe customer
migration. Publish `v2.0.0` only after CI and a reviewed consumer plan pass.

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
