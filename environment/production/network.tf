# VCN
resource "oci_core_vcn" "default_vcn" {
  cidr_block     = "${var.vcn_cidr_block}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.vcn_display_name}"
  dns_label      = "${var.vcn_dns_label}"
  defined_tags   = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
}

# Internet Gateway
resource "oci_core_internet_gateway" "default_internet_gateway" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.default_vcn.id}"
  display_name   = "${var.internet_gateway_display_name}"
  enabled        = true
  defined_tags   = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
}

# Nat Gateway
resource "oci_core_nat_gateway" "default_nat_gateway" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.default_vcn.id}"
  display_name   = "${var.nat_gateway_display_name}"
  defined_tags   = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
}

# public route table
resource "oci_core_route_table" "public_route_table" {
  compartment_id = "${var.compartment_ocid}"
  route_rules {
    network_entity_id = "${oci_core_internet_gateway.default_internet_gateway.id}"
    destination       = "0.0.0.0/0"
  }
  vcn_id       = "${oci_core_vcn.default_vcn.id}"
  display_name = "${var.public_route_table_display_name}"
  defined_tags = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
}

# private route table
resource "oci_core_route_table" "private_route_table" {
  compartment_id = "${var.compartment_ocid}"
  route_rules {
    network_entity_id = "${oci_core_nat_gateway.default_nat_gateway.id}"
    destination       = "0.0.0.0/0"
  }
  vcn_id       = "${oci_core_vcn.default_vcn.id}"
  display_name = "${var.private_route_table_display_name}"
  defined_tags = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
}

# Security Group(default)
resource "oci_core_network_security_group" "default_network_security_group" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.default_vcn.id}"
  defined_tags   = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
  display_name   = "${var.sg_display_name_default}"
}

# Security Group(admin)
resource "oci_core_network_security_group" "admin_network_security_group" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.default_vcn.id}"
  defined_tags   = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
  display_name   = "${var.sg_display_name_admin}"
}

# Security Group(web)
resource "oci_core_network_security_group" "web_network_security_group" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.default_vcn.id}"
  defined_tags   = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
  display_name   = "${var.sg_display_name_web}"
}

# Security Group(db)
resource "oci_core_network_security_group" "db_network_security_group" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.default_vcn.id}"
  defined_tags   = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
  display_name   = "${var.sg_display_name_db}"
}

# Security Group(pub_lb)
resource "oci_core_network_security_group" "pub_lb_network_security_group" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.default_vcn.id}"
  defined_tags   = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
  display_name   = "${var.sg_display_name_pub_lb}"
}

# Security Rule(default)
resource "oci_core_network_security_group_security_rule" "default_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.default_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_tcp}"
  description               = "${var.sg_description_admin_ssh}"
  source                    = "${oci_core_network_security_group.admin_network_security_group.id}"
  source_type               = "${var.sg_source_type_nsg}"
  tcp_options {
    destination_port_range {
      max = "${var.sg_destination_port_range_max_ssh}"
      min = "${var.sg_destination_port_range_min_ssh}"
    }
  }
}

# Security Rule(all ssh to admin)
resource "oci_core_network_security_group_security_rule" "alice_admin_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.admin_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_tcp}"
  description               = "${var.sg_description_all_ssh}"
  source                    = "${var.sg_source_all}"
  source_type               = "${var.sg_source_type_cidr}"
  tcp_options {
    destination_port_range {
      max = "${var.sg_destination_port_range_max_ssh}"
      min = "${var.sg_destination_port_range_min_ssh}"
    }
  }
}

# Security Rule(http to admin)
resource "oci_core_network_security_group_security_rule" "http_admin_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.admin_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_tcp}"
  description               = "${var.sg_description_all_http}"
  source                    = "${var.sg_source_all}"
  source_type               = "${var.sg_source_type_cidr}"
  tcp_options {
    destination_port_range {
      max = "${var.sg_destination_port_range_max_http}"
      min = "${var.sg_destination_port_range_min_http}"
    }
  }
}

# Security Rule(web-sg to admin)
resource "oci_core_network_security_group_security_rule" "web-ngs_admin_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.admin_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_all}"
  description               = "${var.sg_description_web_access}"
  source                    = "${oci_core_network_security_group.web_network_security_group.id}"
  source_type               = "${var.sg_source_type_nsg}"
}

# Security Rule(db-sg to admin)
resource "oci_core_network_security_group_security_rule" "db-ngs_admin_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.admin_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_all}"
  description               = "${var.sg_description_db_access}"
  source                    = "${oci_core_network_security_group.db_network_security_group.id}"
  source_type               = "${var.sg_source_type_nsg}"
}

# Security Rule(lb-sg http to web)
resource "oci_core_network_security_group_security_rule" "lb-http_web_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.web_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_tcp}"
  description               = "${var.sg_description_lb_http}"
  source                    = "${oci_core_network_security_group.pub_lb_network_security_group.id}"
  source_type               = "${var.sg_source_type_nsg}"
  tcp_options {
    destination_port_range {
      max = "${var.sg_destination_port_range_max_http}"
      min = "${var.sg_destination_port_range_min_http}"
    }
  }
}

# Security Rule(lb-sg https to web)
resource "oci_core_network_security_group_security_rule" "lb-https_web_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.web_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_tcp}"
  description               = "${var.sg_description_lb_https}"
  source                    = "${oci_core_network_security_group.pub_lb_network_security_group.id}"
  source_type               = "${var.sg_source_type_nsg}"
  tcp_options {
    destination_port_range {
      max = "${var.sg_destination_port_range_max_https}"
      min = "${var.sg_destination_port_range_min_https}"
    }
  }
}

# Security Rule(admin-sg to web)
resource "oci_core_network_security_group_security_rule" "admin-ngs_web_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.web_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_all}"
  description               = "${var.sg_description_admin_access}"
  source                    = "${oci_core_network_security_group.admin_network_security_group.id}"
  source_type               = "${var.sg_source_type_nsg}"
}

# Security Rule(db-sg to web)
resource "oci_core_network_security_group_security_rule" "db-ngs_web_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.web_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_all}"
  description               = "${var.sg_description_db_access}"
  source                    = "${oci_core_network_security_group.db_network_security_group.id}"
  source_type               = "${var.sg_source_type_nsg}"
}

# Security Rule(web-sg to web)
resource "oci_core_network_security_group_security_rule" "web-ngs_web_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.web_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_all}"
  description               = "${var.sg_description_web_access}"
  source                    = "${oci_core_network_security_group.web_network_security_group.id}"
  source_type               = "${var.sg_source_type_nsg}"
}

# Security Rule(admin-sg to db)
resource "oci_core_network_security_group_security_rule" "admin-ngs_db_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.db_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_all}"
  description               = "${var.sg_description_admin_access}"
  source                    = "${oci_core_network_security_group.admin_network_security_group.id}"
  source_type               = "${var.sg_source_type_nsg}"
}

# Security Rule(web-sg to db)
resource "oci_core_network_security_group_security_rule" "web-ngs_db_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.db_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_all}"
  description               = "${var.sg_description_web_access}"
  source                    = "${oci_core_network_security_group.web_network_security_group.id}"
  source_type               = "${var.sg_source_type_nsg}"
}

# Security Rule(db-sg to db)
resource "oci_core_network_security_group_security_rule" "db-ngs_db_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.db_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_all}"
  description               = "${var.sg_description_db_access}"
  source                    = "${oci_core_network_security_group.db_network_security_group.id}"
  source_type               = "${var.sg_source_type_nsg}"
}

# Security Rule(http to publb)
resource "oci_core_network_security_group_security_rule" "http_publb_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.pub_lb_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_tcp}"
  description               = "${var.sg_description_http}"
  source                    = "${var.sg_source_all}"
  source_type               = "${var.sg_source_type_cidr}"
  tcp_options {
    destination_port_range {
      max = "${var.sg_destination_port_range_max_http}"
      min = "${var.sg_destination_port_range_min_http}"
    }
  }
}

# Security Rule(https to publb)
resource "oci_core_network_security_group_security_rule" "https_publb_network_security_group_security_rule" {
  network_security_group_id = "${oci_core_network_security_group.pub_lb_network_security_group.id}"
  direction                 = "${var.sg_direction_ingress}"
  protocol                  = "${var.sg_protocol_tcp}"
  description               = "${var.sg_description_https}"
  source                    = "${var.sg_source_all}"
  source_type               = "${var.sg_source_type_cidr}"
  tcp_options {
    destination_port_range {
      max = "${var.sg_destination_port_range_max_https}"
      min = "${var.sg_destination_port_range_min_https}"
    }
  }
}

# Subent(elb)
resource "oci_core_subnet" "elb_subnet" {
  availability_domain = "${var.availability_domain}"
  cidr_block          = "${var.elb_subnet_cidr_block}"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_vcn.default_vcn.id}"

  display_name               = "${var.elb_subnet_display_name}"
  dns_label                  = "${var.elb_subnet_dns_label}"
  prohibit_public_ip_on_vnic = "${var.elb_subnet_prohibit_public_ip_on_vnic}"
  route_table_id             = "${oci_core_route_table.public_route_table.id}"
  defined_tags               = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
}

# Subent(admin)
resource "oci_core_subnet" "admin_subnet" {
  availability_domain = "${var.availability_domain}"
  cidr_block          = "${var.admin_subnet_cidr_block}"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_vcn.default_vcn.id}"

  display_name               = "${var.admin_subnet_display_name}"
  dns_label                  = "${var.admin_subnet_dns_label}"
  prohibit_public_ip_on_vnic = "${var.admin_subnet_prohibit_public_ip_on_vnic}"
  route_table_id             = "${oci_core_route_table.public_route_table.id}"
  defined_tags               = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
}

# Subent(Web)
resource "oci_core_subnet" "web_subnet" {
  availability_domain = "${var.availability_domain}"
  cidr_block          = "${var.web_subnet_cidr_block}"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_vcn.default_vcn.id}"

  display_name               = "${var.web_subnet_display_name}"
  dns_label                  = "${var.web_subnet_dns_label}"
  prohibit_public_ip_on_vnic = "${var.web_subnet_prohibit_public_ip_on_vnic}"
  route_table_id             = "${oci_core_route_table.private_route_table.id}"
  defined_tags               = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
}

# Subent(db)
resource "oci_core_subnet" "db_subnet" {
  availability_domain = "${var.availability_domain}"
  cidr_block          = "${var.db_subnet_cidr_block}"
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_vcn.default_vcn.id}"

  display_name               = "${var.db_subnet_display_name}"
  dns_label                  = "${var.db_subnet_dns_label}"
  prohibit_public_ip_on_vnic = "${var.db_subnet_prohibit_public_ip_on_vnic}"
  route_table_id             = "${oci_core_route_table.private_route_table.id}"
  defined_tags               = "${map("${var.defined_tag}", "${var.defined_tag_value}")}"
}