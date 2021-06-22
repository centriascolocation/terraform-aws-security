module "s3_bucket_with_al" {
  source          = "../../modules/secure-s3-bucket"
  bucket_name     = "issue-5-test"
  log_bucket_name = "issue-5-test-al"
  logging = {
    target_bucket = "issue-5-test-al"
    target_prefix = "accesslogs/"
  }
}

module "s3_bucket_with_without_al" {
  source      = "../../modules/secure-s3-bucket"
  bucket_name = "issue-5-test-without-al"
}

data "aws_caller_identity" "current" {}

module "s3_bucket_with_lifecycle" {
  source      = "../../modules/secure-s3-bucket"
  bucket_name = "secure-bucket-lifecycle-${data.aws_caller_identity.current.account_id}"

}
