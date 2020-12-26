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
  region           = "${var.deploy_region}"
}
