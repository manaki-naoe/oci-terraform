variable "NumInstances_web" {
  default = "2"
}

variable "instance_shape_web" {
  default = "VM.Standard.E2.1"
}

variable "instance_host_name_web" {
  default = "default-web"
}

variable "instance_display_name_web" {
  default = "default-web"
}

variable "instance_image_ocid_web" {
  type = "map"
  default = {
    ap-tokyo-1 = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaayxjigcwqiqjncbkm7yxppjqfzsjnbvtjsemrvnwrtpwynausossa"
  }
}

variable "instance_volume_size_web" {
  default = "100"
}

variable "private_ip_web" {
  default = "10.0.20."
}