variable "minimum_password_length" {
  description = "Minimum password length"
  type = number
  default = 20
}

variable "require_lowercase_characters" {
  description = "require_lowercase_characters"
  type = bool
  default = true
}

variable "require_numbers" {
  description = "require_numbers"
  type = bool
  default = true
}

variable "require_uppercase_characters" {
  description = "require_uppercase_characters"
  type = bool
  default = true
}

variable "require_symbols" {
  description = "require_symbols"
  type = bool
  default = true
}

variable "allow_users_to_change_password" {
  description = "allow_users_to_change_password"
  type = bool
  default = true
}