resource "oci_core_instance" "db_instance" {
  count               = "${var.NumInstances_db}"
  availability_domain = "${oci_core_subnet.db_subnet.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  shape               = "${var.instance_shape_db}"
  fault_domain        = "${lookup("${var.fault_domain}", "${count.index}"%2)}"
  hostname_label = "${var.instance_host_name_db}${format("%02d", count.index + 1)}"
  display_name   = "${var.instance_display_name_db}${format("%02d", count.index + 1)}"
  create_vnic_details {
    assign_public_ip = "false"
    private_ip       = "${var.private_ip_db}${format("%d", count.index + 11)}"
    subnet_id        = "${oci_core_subnet.db_subnet.id}"
    nsg_ids          = ["${oci_core_network_security_group.default_network_security_group.id}", "${oci_core_network_security_group.db_network_security_group.id}"]
  }
  source_details {
    boot_volume_size_in_gbs = "${var.instance_volume_size_db}"
    source_id               = "${var.instance_image_ocid_db[var.region]}"
    source_type             = "image"
  }
  metadata = {
    ssh_authorized_keys = "${var.instance_ssh_public_key}"
  }
  defined_tags = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
}