variable "tenancy_ocid" {
  default = "[tenancy OCID]"
}

variable "user_ocid" {
  default = "[user OCID]"
}

variable "fingerprint" {
  default = "[Public API key fingerprint]"
}

variable "private_key_path" {
  default = "/terraform/keys/api_key.pem"
}

variable "region" {
  default = "ap-tokyo-1"
}