variable "NumInstances_db" {
  default = "2"
}

variable "instance_shape_db" {
  default = "VM.Standard.E2.1"
}

variable "instance_host_name_db" {
  default = "default-ndb"
}

variable "instance_display_name_db" {
  default = "default-ndb"
}

variable "instance_image_ocid_db" {
  type = "map"
  default = {
    ap-tokyo-1 = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaayxjigcwqiqjncbkm7yxppjqfzsjnbvtjsemrvnwrtpwynausossa"
  }
}

variable "instance_volume_size_db" {
  default = "100"
}

variable "private_ip_db" {
  default = "10.0.30."
}