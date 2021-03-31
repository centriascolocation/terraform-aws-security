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
