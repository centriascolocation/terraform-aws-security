output "aws_config_configuration_recorder_id" {
  description = "Configuration of created config recorder resource"
  value       = aws_config_configuration_recorder.config.id
}
