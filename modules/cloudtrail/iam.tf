resource "aws_s3_bucket_policy" "this" {
  bucket     = var.bucket_name
  depends_on = [var.bucket_name]
  policy     = data.aws_iam_policy_document.bucket_policy.json
}

data "aws_iam_policy_document" "bucket_policy" {
  version = "2012-10-17"
  statement {
    sid    = "AWSCloudTrailGetBucketAcl"
    effect = "Allow"
    principals {
      identifiers = [
      "cloudtrail.amazonaws.com"]
      type = "Service"
    }
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${var.bucket_name}"]
  }

  statement {
    sid    = "AWSCloudTrailPutObject"
    effect = "Allow"
    principals {
      identifiers = [
      "cloudtrail.amazonaws.com"]
      type = "Service"
    }
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
  }
}
