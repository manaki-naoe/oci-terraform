# VCN
variable "vcn_cidr_block" {
  default = "10.0.0.0/16"
}

variable "vcn_display_name" {
  default = "defaultVCN"
}

variable "vcn_dns_label" {
  default = "defaultVCN"
}

# internet gateway
variable "internet_gateway_display_name" {
  default = "default-igw"
}

# nat gateway
variable "nat_gateway_display_name" {
  default = "default-ntg"
}

# availability_domain
variable "availability_domain" {
  default = "OxDc:AP-TOKYO-1-AD-1"
}

# route table
variable "public_route_table_display_name" {
  default = "public-rtb"
}

variable "private_route_table_display_name" {
  default = "private-rtb"
}

# security group default
variable "sg_display_name_default" {
  default = "default-sg"
}

# security group admin
variable "sg_display_name_admin" {
  default = "admin-sg"
}

# security group web
variable "sg_display_name_web" {
  default = "web-sg"
}

# security group db
variable "sg_display_name_db" {
  default = "db-sg"
}

# security group pub_lb
variable "sg_display_name_pub_lb" {
  default = "pub_lb-sg"
}

# security group rule common
variable "sg_direction_ingress" {
  default = "INGRESS"
}
variable "sg_protocol_tcp" {
  default = "6"
}
variable "sg_protocol_all" {
  default = "ALL"
}
variable "sg_source_all" {
  default = "0.0.0.0/0"
}
variable "sg_source_type_cidr" {
  default = "CIDR_BLOCK"
}
variable "sg_source_type_nsg" {
  default = "NETWORK_SECURITY_GROUP"
}
variable "sg_destination_port_range_max_ssh" {
  default = "22"
}
variable "sg_destination_port_range_min_ssh" {
  default = "22"
}
variable "sg_destination_port_range_max_http" {
  default = "80"
}
variable "sg_destination_port_range_min_http" {
  default = "80"
}
variable "sg_destination_port_range_max_https" {
  default = "443"
}
variable "sg_destination_port_range_min_https" {
  default = "443"
}

# security group rule description
variable "sg_description_admin_ssh" {
  default = "adminセキュリティグループからのSSH"
}

variable "sg_description_all_ssh" {
  default = "全てのIPからのSSH"
}

variable "sg_description_all_http" {
  default = "全てのIPからのHTTPアクセス"
}

variable "sg_description_all_https" {
  default = "全てのIPからのHTTPSアクセス"
}

variable "sg_description_admin_access" {
  default = "adminserverからのアクセス"
}

variable "sg_description_web_access" {
  default = "webserversからのアクセス"
}

variable "sg_description_db_access" {
  default = "dbserversからのアクセス"
}

variable "sg_description_lb_http" {
  default = "ロードバランサからのHTTPアクセス"
}

variable "sg_description_lb_https" {
  default = "ロードバランサからのHTTPSアクセス"
}

variable "sg_description_http" {
  default = "80番へのアクセス"
}

variable "sg_description_https" {
  default = "443番へのアクセス"
}

# subnet elb
variable "elb_subnet_cidr_block" {
  default = "10.0.0.0/26"
}

variable "elb_subnet_display_name" {
  default = "elb-public-subnet"
}

variable "elb_subnet_dns_label" {
  default = "elbpubsubnet"
}

variable "elb_subnet_prohibit_public_ip_on_vnic" {
  default = "false"
}

# subnet admin
variable "admin_subnet_cidr_block" {
  default = "10.0.10.0/26"
}

variable "admin_subnet_display_name" {
  default = "admin-public-subnet"
}

variable "admin_subnet_dns_label" {
  default = "adminpubsubnet"
}

variable "admin_subnet_prohibit_public_ip_on_vnic" {
  default = "false"
}

# subnet web
variable "web_subnet_cidr_block" {
  default = "10.0.20.0/26"
}

variable "web_subnet_display_name" {
  default = "frontend-private-subnet"
}

variable "web_subnet_dns_label" {
  default = "webprisubnet"
}

variable "web_subnet_prohibit_public_ip_on_vnic" {
  default = "true"
}


# subnet db
variable "db_subnet_cidr_block" {
  default = "10.0.30.0/26"
}

variable "db_subnet_display_name" {
  default = "backend-private-subnet"
}

variable "db_subnet_dns_label" {
  default = "dbprisubnet"
}

variable "db_subnet_prohibit_public_ip_on_vnic" {
  default = "true"
}