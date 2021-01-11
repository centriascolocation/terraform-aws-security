output "security_hub_id" {
  description = "Security Hub Id"
  value       = var.enabled ? aws_securityhub_account.this[0] : null
}
