# Example usage of iam-access-analyzer, version v1.0.0:
module "my_iam_access_analyser" {
  source = "git::git@gitlab.com:centrias/terraform-modules/terraform-aws-security.git//modules/iam-access-analyzer?ref=v1.2.0"
}

# Example usage of iam-password-policy, version v1.0.0:
module "my_iam_password_policy" {
  source = "git::git@gitlab.com:centrias/terraform-modules/terraform-aws-security.git//modules/iam-password-policy?ref=v1.2.0"
}

# Create Secure S3 Buckets:
resource "random_pet" "rpet1" {
}

module "secure_bucket" {
  source          = "git::git@gitlab.com:centrias/terraform-modules/terraform-aws-security.git//modules/secure-s3-bucket?ref=v1.2.0"
  bucket_name     = random_pet.rpet1.id
  log_bucket_name = "${random_pet.rpet1.id}-logs"
}

# 1.: CloudTrail Bucket:
module "test_secure_s3_bucket" {
  source          = "./../modules/secure-s3-bucket"
  bucket_name     = "test-251120-logs"
  log_bucket_name = "test-251120-accesslogs"
}

# 2.: CloudTrail itself:
module "test_cloudtrail" {
  source                = "./../modules/cloudtrail"
  trail_name            = "test-251120"
  bucket_name           = "test-251120-logs"
  cloudtrail_depends_on = [module.test_secure_s3_bucket.this_bucket]
}
