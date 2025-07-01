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
  required_version = ">= 1.5.0"
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}

provider "oci" {
  region = var.region
}


resource "oci_identity_api_key" "api-key1" {
  user_id   = var.deploy_user_ocid
  key_value = var.public_key_pem
}
