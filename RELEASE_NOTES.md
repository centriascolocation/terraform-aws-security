This major release modernizes the security baseline modules for AWS Provider 6
and introduces explicit S3 ownership, improved service-delivery policies, and
additional CloudTrail, Config and Security Hub settings.

## Breaking changes

- CloudTrail and Security Hub require AWS Provider >= 6.0. The four updated
  baseline modules require Terraform >= 1.9. Config alone requires AWS Provider
  >= 5.30 and secure-S3-bucket alone requires >= 5.70.
- S3 source, access-log and Config buckets use `BucketOwnerEnforced` instead of
  managed ACLs. Migrate existing ACL-based access to policies before upgrading.
- Some Terraform resource addresses change. Existing deployments require a
  reviewed state migration.
- Bucket outputs expose stable metadata instead of complete provider resource objects.
- `enabled = false` also disables dependent access-log resources.
- CloudTrail and Config delivery policies enforce TLS and restrict service access.
  Config requires the correct account ID.

## Improvements

- Optional CloudTrail KMS encryption and CloudWatch Logs delivery settings.
- Config recorder-role override, resource selection and recording-frequency controls.
- Explicit Security Hub default-standard management and configurable initialization timeout.
- Independently configurable source and access-log lifecycle prefixes.
- Standalone CloudTrail deployments no longer require an Organizations lookup.
- Empty lifecycle expiration blocks are omitted, eliminating the provider warning
  without enabling object expiry.
- CI uses Node.js 24 action runtimes and an explicit Ubuntu 24.04 runner.

## Upgrading

Read [UPGRADING.md](https://github.com/centriascolocation/terraform-aws-security/blob/v2.0.0/UPGRADING.md)
before upgrading from 1.x. Back up the state and review the complete plan before
applying. Do not apply unexpected bucket deletions or bucket-policy removals.

Lifecycle-prefix defaults remain unchanged. Broadening a prefix may activate
existing retention actions.

Automated validation and mock tests cover configuration behavior; they do not
replace verification of actual AWS log delivery and existing-state migrations.
