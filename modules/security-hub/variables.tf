variable "enabled" {
  description = "Set to false will not enable Security Hub at all"
  default     = true
  type        = bool
}

variable "enable_cis_standard" {
  description = "Whether to enable CIS standard"
  default     = false
  type        = bool
}

variable "enable_pci_dss_standard" {
  description = "Whether to enable PCI DSS standard"
  default     = false
  type        = bool
}

variable "enable_aws_foundational_standard" {
  description = "Whether to enable AWS Foundations standard"
  default     = true
  type        = bool
}
