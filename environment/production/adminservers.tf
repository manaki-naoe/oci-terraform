resource "oci_core_instance" "admin_instance" {
  count               = "${var.NumInstances_admin}"
  availability_domain = "${oci_core_subnet.admin_subnet.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  shape               = "${var.instance_shape_admin}"
  hostname_label      = "${var.instance_host_name_admin}"
  display_name        = "${var.instance_display_name_admin}"
  create_vnic_details {
    subnet_id        = "${oci_core_subnet.admin_subnet.id}"
    assign_public_ip = true
    private_ip       = "${var.private_ip_admin}"
    nsg_ids          = ["${oci_core_network_security_group.default_network_security_group.id}", "${oci_core_network_security_group.admin_network_security_group.id}"]
  }
  source_details {
    boot_volume_size_in_gbs = "${var.instance_volume_size_admin}"
    source_id               = "${var.instance_image_ocid_admin[var.region]}"
    source_type             = "image"
  }
  metadata = {
    ssh_authorized_keys = "${var.instance_ssh_public_key}"
  }
  defined_tags = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
}
