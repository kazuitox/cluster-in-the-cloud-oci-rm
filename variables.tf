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
    //eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa527xpybx2azyhcz2oyk6f4lsvokyujajo73zuxnnhcnp7p24pgva"
    //uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaarruepdlahln5fah4lvm7tsf4was3wdx75vfs6vljdke65imbqnhq"
    //ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaa7ac57wwwhputaufcbf633ojir6scqa4yv6iaqtn3u64wisqd3jjq"
    //us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaannaquxy7rrbrbngpaqp427mv426rlalgihxwdjrz3fr2iiaxah5a"
    //us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaactxf4lnfjj6itfnblee3g3uckamdyhqkwfid6wslesdxmlukqvpa"
    //ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaasd7bfo4bykdf3jlb7n5j46oeqxwj2r3ub4ly36db3pmrlmlzzv3a"
    //ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaacdrxj4ktv6qilozzc7bkhcrdlzri2gw4imlljpg255stxvkbgpnq"
    //
    // Oracle-Linux-7.8-2020.05.26-0
    ap-chuncheon-1   = "ocid1.image.oc1.ap-chuncheon-1.aaaaaaaacafxt4pkkeqnk5rg6a273jrmz43tqucc5dxwwnvqaotocuayydea"
    ap-hyderabad-1   = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaawgptjzk2fivaomlk2pl3lfeej75fibo2gkfiesm5hgqpeltwdlxa"
    ap-melbourne-1   = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaaaqmcv4ddtdbh2n2gxx7lv3ukey4bp7dolxh4lfdogmobplikgq3q"
    ap-mumbai-1      = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaaqkzwsqkmnsjqjeooqfwmdt2cfsfzk35zcl2dnen4vgukyduknczq"
    ap-osaka-1       = "ocid1.image.oc1.ap-osaka-1.aaaaaaaamncxeztxzrnze2aub4dtygiuj2tzmtr4tyr55wtj4s3evsnofocq"
    ap-seoul-1       = "ocid1.image.oc1.ap-seoul-1.aaaaaaaaajtaaclrr7y6pnqxu6w4f6fl7ozxwuyuhnw3iqp3mt3hjd5bp3aa"
    ap-sydney-1      = "ocid1.image.oc1.ap-sydney-1.aaaaaaaaxmdqbkr54qvvh2jovbjdbn5zzdevhxsh73vwpnpnanu3cyarkoja"
    ap-tokyo-1       = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaanvewa7zsczldkfp64w2mml3wmakanbnm2fnrdtcmpvzofcatbiia"
    ca-montreal-1    = "ocid1.image.oc1.ca-montreal-1.aaaaaaaarpj5lmzvkaj2kgydcqncxl2ypmzzg4fglcc5mlmw5qvcrzvylxxq"
    ca-toronto-1     = "ocid1.image.oc1.ca-toronto-1.aaaaaaaaxtf4mn34apqvpq6rvmedbdyaxx5ynojin4pefnrh3pnqeghjyefa"
    eu-amsterdam-1   = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaae5pwbjadmkl4h7chcwumzpv6xfka7vu4n7ruah3uwspnmq5uod4q"
    eu-frankfurt-1   = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaafjcegvwbd3qgin4unmtr5jm5gjhtcfxgnhjwodzewlja5zqm6eaq"
    eu-zurich-1      = "ocid1.image.oc1.eu-zurich-1.aaaaaaaaxfznq6vkvzxmqxsyvrrsgtciq523wtf7yalo6vntnpijjqzk2huq"
    me-jeddah-1      = "ocid1.image.oc1.me-jeddah-1.aaaaaaaaunxkcgizo3yfcxuidrd3x2ulmmrs4x646qh4ifffnwsxmerfv2tq"
    sa-saopaulo-1    = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaazka4sywunfwvasckl6ylrypvntss3adfsqoc3ry6pygkkbikif3q"
    uk-gov-london-1  = "ocid1.image.oc4.uk-gov-london-1.aaaaaaaaxdgrnjymgpy5337bxcgytzicx3tuzr2su4h2wm2hketi7mf5ebla"
    uk-london-1      = "ocid1.image.oc1.uk-london-1.aaaaaaaa4srleqj6rpvdtzvlrkz4bf6dnpunm732edde6bo6ve5ym2v43qwa"
    us-ashburn-1     = "ocid1.image.oc1.iad.aaaaaaaashyy2whsxs65paokuhg5uyjjqq3x54tnix5all4jjxzvdlz6kltq"
    us-gov-ashburn-1 = "ocid1.image.oc3.us-gov-ashburn-1.aaaaaaaaf7bjsrwqsx44mser7gbqgels34vnlvydj5yolln7fuvtwqmwxx3a"
    us-gov-chicago-1 = "ocid1.image.oc3.us-gov-chicago-1.aaaaaaaa5y7ck4baxk5m7hfuzbex6s6xwevqxhmg57czv3l2nfkhymjdo3dq"
    us-gov-phoenix-1 = "ocid1.image.oc3.us-gov-phoenix-1.aaaaaaaa4vf5lstyhsk2pi3bvahesgo4hlhkudoqwmkl6yd2eexg5rai5r3q"
    us-langley-1     = "ocid1.image.oc2.us-langley-1.aaaaaaaav5olkzxsceul3iaoksna44qfxw5l3qkogqiryodhjom43hievgfa"
    us-luke-1        = "ocid1.image.oc2.us-luke-1.aaaaaaaankkfzglxgk56u7rmqfmb3g3uau3phf4sv5dgqt6plvnq5dmc6guq"
    us-phoenix-1     = "ocid1.image.oc1.phx.aaaaaaaay2kmwg3owseae3ppamxzegb3x4ezitizh6pyhnahzqmubfhxvmhq"
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
