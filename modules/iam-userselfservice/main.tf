resource "aws_iam_policy" "this" {
  name        = var.policy_name
  description = var.policy_description

  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {

  version = "2012-10-17"
  statement {
    sid    = "AllowViewAccountInfo"
    effect = "Allow"
    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowManageOwnPasswords"
    effect = "Allow"
    actions = [
      "iam:ChangePassword",
      "iam:GetUser",
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }
  statement {
    sid    = "IAMAccessKeyPolicy"
    effect = "Allow"
    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:UpdateAccessKey",
      "iam:GetAccessKeyLastUsed",
      "iam:ListAccessKeys",
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }
  statement {
    sid    = "AllowManageOwnSSHPublicKeys"
    effect = "Allow"
    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }
  statement {
    sid    = "AllowMFADeviceHandling"
    effect = "Allow"
    actions = [
      "iam:DeactivateMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:CreateVirtualMFADevice",
      "iam:ListMFADevices",
    ]
    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}",
    ]
  }
  statement {
    sid    = "AllowMFAListing"
    effect = "Allow"
    actions = [
      "iam:ListVirtualMFADevices",
    ]
    resources = [
      "*",
    ]
  }
}
