# Upgrading to v2.0.0

These changes are breaking changes. Do not backport silently into existing 1.x
customer deployments. CloudTrail now requires AWS Provider >= 6.0. The four updated baseline modules require Terraform >= 1.9. All commands below are examples; substitute actual module paths.
Back up the state, stop concurrent applies, and review the complete plan first.

## Bucket ownership

Secure source buckets, access-log buckets and Config buckets explicitly use
`BucketOwnerEnforced`. There are no managed ACL resources anymore. Before upgrading,
inspect existing bucket and object ACLs, transfer necessary access to policies, and
reset non-owner bucket grants to a private owner-only ACL. S3 rejects ownership
changes when external bucket ACL grants remain. Existing object ACLs become inactive.
Confirm that every writer supports ACL-free writes or `bucket-owner-full-control`.

Remove only the obsolete ACL addresses from Terraform state, without destroying
or replacing the buckets, after reviewing the grants and preparing policies:

```sh
terraform state rm 'module.test_secure_s3_bucket.aws_s3_bucket_acl.secure_s3_bucket_acl[0]'
terraform state rm 'module.test_secure_s3_bucket.aws_s3_bucket_acl.access_log_acl[0]'
terraform state rm 'module.test_config.aws_s3_bucket_acl.config_acl'
```

Repeat for all affected module instances. Install/verify the logging service's
bucket-policy permission before enforcing ownership on existing log buckets.
The module grants `logging.s3.amazonaws.com` PutObject access limited to the source
bucket ARN, caller account and configured target prefix. Actual delivery needs an
AWS integration check; mock plans cannot prove AWS acceptance or log delivery.

## Exactly one policy owner

The complete example sets `manage_bucket_policy = false` on the CloudTrail source
S3 module. CloudTrail owns the complete policy: TLS deny, GetBucketAcl and PutObject,
with service permissions scoped to the trail ARN. Keep the separate access-log
bucket policy managed by S3. Other source buckets retain the S3 module's TLS policy.

For existing state containing BOTH resources for the same bucket, forget the S3
policy address; do not apply its planned destruction, which would delete the shared
remote policy. Move the retained CloudTrail address to its new counted address:

```sh
terraform state rm 'module.test_secure_s3_bucket.aws_s3_bucket_policy.secure_s3_bucket'
terraform state mv 'module.test_cloudtrail.aws_s3_bucket_policy.this' 'module.test_cloudtrail.aws_s3_bucket_policy.this[0]'
```

If only the S3 address exists, move it directly to the CloudTrail policy address
instead. If neither exists but the remote policy does, import it into the chosen
owner. Preserve any customer-specific statements in the final composed policy.
For S3-owned policies that remain enabled, move the old uncounted address to `[0]`.
The counted sleeps may also be moved to `[0]` to avoid rerunning the waits.

CloudTrail can alternatively use `manage_bucket_policy = false` and export
`bucket_policy_json` for composition by an external owner. Install that policy and
make trail creation depend on it, using an explicit module dependency or the
existing `cloudtrail_depends_on` input. Do not make the external policy depend on
trail creation; its ARN is derived independently to avoid a dependency cycle.

## Standalone and organization trails

Standalone mode performs no Organizations lookup. Organization mode queries only
organization metadata and uses the management-account ID for the SourceArn and
account delivery path, plus the organization delivery path. Provider 6.67.0 still
exports that ID as `master_account_id`; there is no `management_account_id` field
in this data source's schema. Organization permissions/delegated administration
remain prerequisites; this change does not configure them.

## Scope and remaining findings

`enabled = false` now disables source/log buckets and all their dependents.
Lifecycle action validation, logging-input validation, Config startup ordering, Security Hub
and CI modernization remain separate follow-up work from the baseline review.
The complete example still requires explicit logging configuration to enable
source-bucket access logging.

References:
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-server-access-logging.html
- https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html

## Lifecycle prefixes

`lifecycle_prefix` and `access_log_lifecycle_prefix` default to `/` for
compatibility. This matches only keys starting with `/`. Set a deliberate prefix
such as `AWSLogs/`, or an empty string for all keys. Broadening a prefix can
activate existing archival or expiry rules; review retention before applying.

## Bucket output contract

`this_bucket` and `log_bucket` return stable metadata rather than full provider
resource objects: `id`, `arn`, `bucket`, domain names, `bucket_region`,
`hosted_zone_id`, `tags` and `tags_all`. Disabled buckets return `null`.
Migrate references to removed inline attributes to module inputs or dedicated
Terraform resources. This API change does not itself replace a bucket.

## Optional CloudTrail and Config settings

CloudTrail supports optional KMS encryption and CloudWatch Logs delivery inputs.
Callers remain responsible for key policies and delivery-role permissions.
Config supports an optional `recorder_role_arn`; the existing managed custom role
is retained to avoid deleting it when an external recorder role is selected.
Config bucket delivery is TLS-only and scoped to the supplied `aws_account_id`.
Supply the real account ID before upgrading.

When replacing a locally customized module with this release, compare its inputs,
outputs, security policies and resource addresses first. Preserve module block
names and inspect actual state; do not repeat migrations already performed.
After a reviewed apply, verify log delivery, recording and subscriptions, then
confirm the next plan contains no unexpected changes.

## Known limitations

Mock tests do not prove live service delivery or a safe migration of existing
state. Organization trails require the appropriate permissions and live testing.
Empty source expiration settings now omit the expiration block; no object expiry
is enabled unless explicitly configured. A non-empty `logging` map requires a valid `log_bucket_name`.
