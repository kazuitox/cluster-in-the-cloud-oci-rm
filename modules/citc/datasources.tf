# Gets a list of Availability Domains

data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

#data "template_file" "user_data" {
#  template = file("${path.module}/../common-files/bootstrap.sh.tpl")
#  vars = {
#    ansible_branch = var.ansible_branch
#    cloud-platform = "oracle"
#    fileserver-ip  = "" # the file server is determined via a static name on OCI
#    custom_block = ""
#  }
#}

data "oci_core_images" "linux" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "7.9"
  filter {
    name   = "display_name"
    values = ["^([a-zA-z]+)-([a-zA-z]+)-([\\.0-9]+)-([\\.0-9-]+)$"]
    regex  = true
  }
}
