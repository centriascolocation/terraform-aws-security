variable "config_name" {
  default = ""
}
variable "config_bucket_prefix" {
  default = "config"
}
variable "common_tags" {
  default = ""
}
variable "config_bucket_key_prefix" {
  default = "config"
}
variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots."
  default     = "Six_Hours"
  type        = string
}
