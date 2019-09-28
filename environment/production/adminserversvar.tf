variable "NumInstances_admin" {
  default = "1"
}

variable "instance_shape_admin" {
  default = "VM.Standard.E2.1"
}

variable "instance_host_name_admin" {
  default = "default-admin"
}

variable "instance_display_name_admin" {
  default = "default-admin"
}

variable "instance_image_ocid_admin" {
  type = "map"
  default = {
    ap-tokyo-1 = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaayxjigcwqiqjncbkm7yxppjqfzsjnbvtjsemrvnwrtpwynausossa"
  }
}

variable "instance_volume_size_admin" {
  default = "140"
}

variable "private_ip_admin" {
  default = "10.0.10.11"
}