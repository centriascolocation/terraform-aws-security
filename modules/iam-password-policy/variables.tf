variable "minimum_password_length" {
  description = "Minimum password length"
  type        = number
  default     = 20
}

variable "require_lowercase_characters" {
  description = "Whether lowercase chars are required"
  type        = bool
  default     = true
}

variable "require_numbers" {
  description = "Whether numbers are required"
  type        = bool
  default     = true
}

variable "require_uppercase_characters" {
  description = "Whether uppercase chars are required"
  type        = bool
  default     = true
}

variable "require_symbols" {
  description = "Whether symbos are required"
  type        = bool
  default     = true
}

variable "allow_users_to_change_password" {
  description = "Allow users to change their passwords"
  type        = bool
  default     = true
}

variable "password_reuse_prevention" {
  description = "The number of previous passwords that users are prevented from reusing"
  type        = number
  default     = 5
}
