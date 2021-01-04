resource "oci_core_virtual_network" "ClusterVCN" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "ClusterVCN"
  dns_label      = "clustervcn"
}

resource "oci_core_subnet" "PublicSubnet" {
  cidr_block        = "10.1.1.0/24"
  display_name      = "Public"
  dns_label         = "public"
  security_list_ids = [oci_core_virtual_network.ClusterVCN.default_security_list_id, oci_core_security_list.ClusterSecurityList.id]
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.ClusterVCN.id
  route_table_id    = oci_core_route_table.ClusterRT.id
  dhcp_options_id   = oci_core_dhcp_options.Public.id
}
resource "oci_core_subnet" "PrivateSubnet" {
  cidr_block        = "10.1.2.0/24"
  display_name      = "Private"
  dns_label         = "private"
  security_list_ids = [oci_core_security_list.PrivateSecurityList.id]
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.ClusterVCN.id
  route_table_id    = oci_core_route_table.PrivateRT.id
  dhcp_options_id   = oci_core_dhcp_options.Private.id
  prohibit_public_ip_on_vnic = true
}

resource "oci_core_dhcp_options" "Public" {
    compartment_id = var.compartment_ocid
    options {
        type = "DomainNameServer"
        server_type = "VcnLocalPlusInternet"
    }
    options {
        type = "SearchDomain"
        search_domain_names = [ "private.clustervcn.oraclevcn.com" ]
    }
    vcn_id = oci_core_virtual_network.ClusterVCN.id
    display_name = "Public"
}

resource "oci_core_dhcp_options" "Private" {
    compartment_id = var.compartment_ocid
    options {
        type = "DomainNameServer"
        server_type = "VcnLocalPlusInternet"
    }
    options {
        type = "SearchDomain"
        search_domain_names = [ "public.clustervcn.oraclevcn.com" ]
    }
    vcn_id = oci_core_virtual_network.ClusterVCN.id
    display_name = "Private"
}

resource "oci_core_internet_gateway" "ClusterIG" {
  compartment_id = var.compartment_ocid
  display_name   = "ClusterIG"
  vcn_id         = oci_core_virtual_network.ClusterVCN.id
}
resource "oci_core_nat_gateway" "PrivateNAT" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.ClusterVCN.id
  display_name   = "PrivateNAT"
}

resource "oci_core_route_table" "ClusterRT" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.ClusterVCN.id
  display_name   = "ClusterRT"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.ClusterIG.id
  }
}
resource "oci_core_route_table" "PrivateRT" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.ClusterVCN.id
  display_name   = "PrivateRT"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.PrivateNAT.id
  }
}

resource "oci_core_security_list" "ClusterSecurityList" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.ClusterVCN.id
  display_name   = "ClusterSecurityList"

  // allow inbound ssh traffic from a specific port
  ingress_security_rules {
    # Open all ports within the private network
    protocol = "all"
    source   = "10.1.0.0/16"
  }
  ingress_security_rules {
    # Open port for Grafana
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 3000
      max = 3000
    }
  }
}
resource "oci_core_security_list" "PrivateSecurityList" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.ClusterVCN.id
  display_name   = "PrivateSecurityList"

  // allow inbound ssh traffic from a specific port
  ingress_security_rules {
    # Open all ports within the private network
    protocol = "all"
    source   = "10.1.0.0/16"
  }
  egress_security_rules {
    # Open all ports within the private network
    protocol = "all"
    destination   = "0.0.0.0/0"
  }
}
