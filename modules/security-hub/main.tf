data "aws_region" "current" {}

resource "aws_securityhub_account" "this" {
  count = var.enabled ? 1 : 0
}

# --------------------------------------------------------------------------------------------------
# Subscribe AWS foundational security best practices standard
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "aws_foundational" {
  count = var.enabled && var.enable_aws_foundational_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/aws-foundational-security-best-practices/v/1.0.0"

  depends_on = [aws_securityhub_account.this]
}

# --------------------------------------------------------------------------------------------------
# Subscribe CIS benchmark
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "cis" {
  count = var.enabled && var.enable_cis_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"

  depends_on = [aws_securityhub_account.this]
}

# --------------------------------------------------------------------------------------------------
# Subscribe PCI DSS standard
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "pci_dss" {
  count = var.enabled && var.enable_pci_dss_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/pci-dss/v/3.2.1"

  depends_on = [aws_securityhub_account.this]
}
