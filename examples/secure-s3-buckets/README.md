# Examples

You can use this module as follows:

```

  terraform init
  terraform plan
  terraform apply

```

## MFA on delete

You can add another layer of protection by enabling MFA Delete on a versioned bucket.
Once you do so, you must provide your AWS account’s access keys and a valid code from the account’s MFA device
in order to permanently delete an object version or suspend or reactivate versioning on the bucket.

Note:  MFA Delete only works for CLI or API interaction, not in the AWS Management Console.
Also, you cannot make version DELETE actions with MFA using IAM user credentials.
You must use your root AWS account to deploy the following example.

```hcl

data "aws_caller_identity" "current" {}

module "s3_bucket_with_mfa_on_delete" {
  source      = "../../modules/secure-s3-bucket"
  bucket_name = "secure-bucket-lifecycle-${data.aws_caller_identity.current.account_id}"
  mfa_delete = true
}

```

## Customized Lifecycle Rules For Objects

If you will not define explicitly all objects will transition to GLACIER storage class after 90 days.
You have the choice to customize these settings for current and non-current objects. In this example
you see how to remove lifecycle rule for current objects and change rule for non-current objects.

```hcl
module "s3_bucket_with_lifecycle_customized" {
  source      = "../../modules/secure-s3-bucket"
  bucket_name = "secure-bucket-lifecycle-${data.aws_caller_identity.current.account_id}"
  lifecycle_rule_current_version = {
  }
  lifecycle_rule_noncurrent_version = {
    days          = 365
    storage_class = "GLACIER"
  }
}

```

See [main.tf](https://github.com/centriascolocation/terraform-aws-security/blob/master/examples/secure-s3-buckets/main.tf) for details!

### See also

* https://www.terraform.io/docs/modules/sources.html#generic-git-repository
