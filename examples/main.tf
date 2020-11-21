# Example usage of iam-access-analyzer, version v1.0.0:
module "my_iam_access_analyser" {
  source = "git::git@gitlab.com:centrias/terraform-modules/terraform-aws-security.git//modules/iam-access-analyzer?ref=v1.0.0"
}

# Example usage of iam-password-policy, version v1.0.0:
module "my_iam_password_policy" {
  source = "git::git@gitlab.com:centrias/terraform-modules/terraform-aws-security.git//modules/iam-password-policy?ref=v1.0.0"
}
