variable "region" {
  description = "Home Region"
}

variable "deploy_region" {
  description = "Deployment Region"
}

variable "deploy_user_ocid" {
}

variable "deploy_ad" {
}

variable "tenancy_ocid" {
}
variable "compartment_ocid" {
}

variable "ManagementShape" {
  description = "The shape to use for the management node"
  default     = "VM.Standard2.1"
}

variable "ManagementImageOCID" {
  description = "What image to use for the management node. A map of region name to image OCID."
  type        = map(string)

  default = {
    // See https://docs.cloud.oracle.com/iaas/images/
    // Oracle-Linux-7.6-2019.02.20-0
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa527xpybx2azyhcz2oyk6f4lsvokyujajo73zuxnnhcnp7p24pgva"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaarruepdlahln5fah4lvm7tsf4was3wdx75vfs6vljdke65imbqnhq"
    ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaa7ac57wwwhputaufcbf633ojir6scqa4yv6iaqtn3u64wisqd3jjq"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaannaquxy7rrbrbngpaqp427mv426rlalgihxwdjrz3fr2iiaxah5a"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaactxf4lnfjj6itfnblee3g3uckamdyhqkwfid6wslesdxmlukqvpa"
    ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaasd7bfo4bykdf3jlb7n5j46oeqxwj2r3ub4ly36db3pmrlmlzzv3a"
    ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaacdrxj4ktv6qilozzc7bkhcrdlzri2gw4imlljpg255stxvkbgpnq"
  }
}

variable "ExportPathFS" {
  default = "/shared"
}

variable "ClusterNameTag" {
  default = "cluster"
}

variable "ansible_branch" {
  default = "4"
}
