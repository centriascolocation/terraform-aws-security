output "this_policy_arn" {
  description = "the Policy ARN"
  value       = aws_iam_policy.this.arn
}

output "this_policy_name" {
  description = "the Policy Name"
  value       = aws_iam_policy.this.name
}
