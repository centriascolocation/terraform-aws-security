data "aws_region" "current" {}
data "aws_partition" "current" {}

resource "aws_securityhub_account" "this" {
  count = var.enabled ? 1 : 0

  enable_default_standards = var.enable_default_standards
}

# --------------------------------------------------------------------------------------------------
# Subscribe AWS foundational security best practices standard
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "aws_foundational" {
  count = var.enabled && var.enable_aws_foundational_standard ? 1 : 0

  standards_arn = "arn:${data.aws_partition.current.partition}:securityhub:${data.aws_region.current.region}::standards/aws-foundational-security-best-practices/v/1.0.0"

  timeouts {
    create = var.standards_create_timeout
  }

  depends_on = [aws_securityhub_account.this]
}

# --------------------------------------------------------------------------------------------------
# Subscribe CIS benchmark
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "cis" {
  count = var.enabled && var.enable_cis_standard ? 1 : 0

  standards_arn = "arn:${data.aws_partition.current.partition}:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"

  timeouts {
    create = var.standards_create_timeout
  }

  depends_on = [aws_securityhub_account.this]
}

# --------------------------------------------------------------------------------------------------
# Subscribe PCI DSS standard
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "pci_dss" {
  count = var.enabled && var.enable_pci_dss_standard ? 1 : 0

  standards_arn = "arn:${data.aws_partition.current.partition}:securityhub:${data.aws_region.current.region}::standards/pci-dss/v/3.2.1"

  timeouts {
    create = var.standards_create_timeout
  }

  depends_on = [aws_securityhub_account.this]
}
