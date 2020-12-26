variable "public_key_pem" {
   type = string
}
variable "region" {
   type = string
}
variable "deploy_user_ocid" {
   type = string
}

terraform {
  required_version = "~> 0.12"
}

provider "template" {
  version = "~> 2.1"
}

provider "tls" {
  version = "~> 2.0"
}

provider "oci" {
  version          = ">= 3.23.0"
  region           = "${var.region}"
}


resource "oci_identity_api_key" "api-key1" {
  user_id = "${var.deploy_user_ocid}"
  key_value = "${var.public_key_pem}"
}
