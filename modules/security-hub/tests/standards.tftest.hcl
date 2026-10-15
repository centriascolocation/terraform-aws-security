mock_provider "aws" {
  mock_data "aws_region" { defaults = { region = "eu-central-1" } }
  mock_data "aws_partition" { defaults = { partition = "aws" } }
}
run "terraform_managed_fsbp_only" {
  command = plan
  variables { enable_default_standards = false }
  assert {
    condition     = !aws_securityhub_account.this[0].enable_default_standards && length(aws_securityhub_standards_subscription.aws_foundational) == 1 && length(aws_securityhub_standards_subscription.cis) == 0 && length(aws_securityhub_standards_subscription.pci_dss) == 0
    error_message = "Enable only Terraform-managed FSBP without automatic CIS or PCI subscriptions."
  }
  assert {
    condition     = aws_securityhub_standards_subscription.aws_foundational[0].standards_arn == "arn:aws:securityhub:eu-central-1::standards/aws-foundational-security-best-practices/v/1.0.0"
    error_message = "FSBP subscription must target the current partition and Region."
  }
}
