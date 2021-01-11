resource "aws_securityhub_account" "this" {
  count = var.enabled ? 1 : 0
}
