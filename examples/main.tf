module "my_iam_access_analyser" {
  source = "./../modules/iam-access-analyzer"
}

module "my_iam_password_policy" {
  source = "./../modules/iam-password-policy"
}

# Create Secure S3 Buckets:
resource "random_pet" "rpet1" {
}

module "secure_bucket" {
  source          = "./../modules/secure-s3-bucket"
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

# Add an IAM group and allow users of that group to manage their password, accesskeys and ssh public keys:
module "test_iam_uss" {
  source             = "./../modules/iam-userselfservice"
  policy_name        = "test_iam_uss"
  policy_description = "Allow Users to manage things on their behalf"
}

resource "aws_iam_group" "iam_self_service_users" {
  name = "iam_self_service_users"
}

resource "aws_iam_group_policy_attachment" "iam_self_service_attach" {
  group      = aws_iam_group.iam_self_service_users.name
  policy_arn = module.test_iam_uss.this_policy_arn
}
