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

# Generate Key
module "module_generate_key" {

  source = "./modules/generate_key"

}

# Add API-Key
module "module_api_key" {

  source = "./modules/api_key"

  deploy_user_ocid = var.deploy_user_ocid
  region           = var.region
  public_key_pem   = module.module_generate_key.public_key_pem
}

## make Cluster in the Cloud
module "module_citc" {
  source = "./modules/citc"

  public_key_openssh = module.module_generate_key.public_key_openssh
  private_key_pem    = module.module_generate_key.private_key_pem
  user_fingerprint   = module.module_api_key.user_fingerprint
  deploy_user_ocid   = var.deploy_user_ocid
  tenancy_ocid       = var.tenancy_ocid
  deploy_region      = var.deploy_region
  compartment_ocid   = var.compartment_ocid
  ManagementAD       = var.deploy_ad
  FilesystemAD       = var.deploy_ad
  ManagementShape    = var.ManagementShape
  ExportPathFS       = var.ExportPathFS
  ClusterNameTag     = var.ClusterNameTag
}

## Output
output "sshPrivateKey" {
  value     = module.module_generate_key.private_key_pem
  sensitive = true
}
output "ManagementPublicIP" {
  value = module.module_citc.ManagementPublicIP
}
