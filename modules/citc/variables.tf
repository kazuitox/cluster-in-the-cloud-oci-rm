variable "public_key_openssh" {
  type = string
}
variable "private_key_pem" {
  type = string
}
variable "user_fingerprint" {
  type = string
}
variable "tenancy_ocid" {
  type = string
}
variable "deploy_region" {
  type = string
}
variable "compartment_ocid" {
  type = string
}
variable "deploy_user_ocid" {
  type = string
}
variable "ManagementAD" {
  type = number
}
variable "FilesystemAD" {
  type = number
}
variable "ManagementShape" {
  type = string
}
variable "ManagementImageOCID" {
  description = "What image to use for the management node. A map of region name to image OCID."
  type        = map(string)

  default = {
    // See https://docs.cloud.oracle.com/iaas/images/
    // Oracle-Linux-7.6-2019.02.20-0 -> Oracle-Linux-7.8-2020.07.28-0
    //eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa527xpybx2azyhcz2oyk6f4lsvokyujajo73zuxnnhcnp7p24pgva"
    //uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaarruepdlahln5fah4lvm7tsf4was3wdx75vfs6vljdke65imbqnhq"
    //ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaa7ac57wwwhputaufcbf633ojir6scqa4yv6iaqtn3u64wisqd3jjq"
    //us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaannaquxy7rrbrbngpaqp427mv426rlalgihxwdjrz3fr2iiaxah5a"
    //us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaactxf4lnfjj6itfnblee3g3uckamdyhqkwfid6wslesdxmlukqvpa"
    //ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaasd7bfo4bykdf3jlb7n5j46oeqxwj2r3ub4ly36db3pmrlmlzzv3a"
    //ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaacdrxj4ktv6qilozzc7bkhcrdlzri2gw4imlljpg255stxvkbgpnq"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaahxue6crkdeevk75bzw63cmhh3c4uyqddcwov7mwlv7na4lkz7zla"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaad3ykcml7uxbkl7oqxbnydtqslgg6oyz35ju5szz4lwttjxi36yua"
    ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaaemkdkubr2znyndgbrhmgn4e2quojqu3maurpf2whxqp3p7bl5spq"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaakcggae4tjdluuizz2if7zivhk2ch47yiqyrrhr7qgygchu7ddyla"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaa75jewsxs5j5lwtucurynvmf6aomgkm5ty33c23vb6ouxxoj2tu3q"
    ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaaj3mfguqxhzfxv3ajhd5r3unryam5ty3zl3cgfck6kt4fcbnd6gpa"
    ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaambznhuxe3nw75c7r3ivucmkqcxpd7i4zkxixkwbntzbvcrphkkqq"
  }
}
variable "ExportPathFS" {
  type = string
}
variable "ClusterNameTag" {
  type = string
}
variable "ansible_branch" {
  default = "4"
}
