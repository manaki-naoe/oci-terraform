variable "compartment_ocid" {
  default = "[compartment OCID]"
}

variable "defined_tag" {
  default = "[namespace.key]"
}

variable "defined_tag_value" {
  default = "[Tag value]"
}

variable "fault_domain" {
  default = {
    "0" = "FAULT-DOMAIN-1"
    "1" = "FAULT-DOMAIN-2"
  }
}

variable "instance_ssh_public_key" {
  default = "Public key value to pass to the instance"
}