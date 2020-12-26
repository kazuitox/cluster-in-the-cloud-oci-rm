resource "oci_core_instance" "ClusterManagement" {
  availability_domain = data.oci_identity_availability_domains.ADs.availability_domains[var.ManagementAD - 1]["name"]
  compartment_id      = var.compartment_ocid
  display_name        = "mgmt"
  shape               = var.ManagementShape

  # Make sure that the manangement node depands on the filesystem so that when
  # destroying, the filesystem is still running in order to perform cleanup of
  # any compute nodes.
  depends_on = [oci_file_storage_export.ClusterFSExport]

  create_vnic_details {
    # ManagementAD
    subnet_id = oci_core_subnet.ClusterSubnet.id

    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = "mgmt"
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.linux.images.0.id
  }

  metadata = {
    ssh_authorized_keys = "${var.public_key_openssh}"
  #  user_data           = base64encode(data.template_file.user_data.rendered)
  }

  timeouts {
    create = "60m"
  }

  freeform_tags = {
    "cluster"  = var.ClusterNameTag
    "nodetype" = "mgmt"
  }

  provisioner "file" {
    destination = "/tmp/shapes.yaml"
    source      = "${path.module}/files/shapes.yaml"

    connection {
      timeout     = "15m"
      host        = oci_core_instance.ClusterManagement.public_ip
      user        = "opc"
      agent       = false
      private_key = "${var.private_key_pem}"
    }
  }

  provisioner "file" {
    destination = "/tmp/ansible.sh"
    source      = "${path.module}/files/ansible.sh"

    connection {
      timeout     = "15m"
      host        = oci_core_instance.ClusterManagement.public_ip
      user        = "opc"
      agent       = false
      private_key = "${var.private_key_pem}"
    }
  }

  provisioner "remote-exec" {
    connection {
      timeout     = "15m"
      host        = oci_core_instance.ClusterManagement.public_ip
      user        = "opc"
      private_key = "${var.private_key_pem}"
    }

    inline = [
      "echo \"${var.private_key_pem}\" > ~/oci_api_key.pem"
    ]
  }

  provisioner "file" {
    destination = "/home/opc/config"
    content     = <<EOF
[DEFAULT]
user=${var.deploy_user_ocid}
fingerprint=${var.user_fingerprint}
key_file=/home/slurm/.oci/oci_api_key.pem
tenancy=${var.tenancy_ocid}
region=${var.deploy_region}
EOF


    connection {
      timeout     = "15m"
      host        = oci_core_instance.ClusterManagement.public_ip
      user        = "opc"
      agent       = false
      private_key = "${var.private_key_pem}"
    }
  }

  provisioner "file" {
    destination = "/home/opc/limits.yaml"
    source      = "${path.module}/files/sample.limits.yaml"

    connection {
      timeout     = "15m"
      host        = oci_core_instance.ClusterManagement.public_ip
      user        = "opc"
      agent       = false
      private_key = "${var.private_key_pem}"
    }
  }


  provisioner "file" {
    destination = "/home/opc/mgmt_shape.yaml"
    content     = <<EOF
mgmt_ad: ${var.ManagementAD}
mgmt_shape: ${var.ManagementShape}
EOF


    connection {
      timeout     = "15m"
      host        = oci_core_instance.ClusterManagement.public_ip
      user        = "opc"
      agent       = false
      private_key = "${var.private_key_pem}"
    }
  }

  provisioner "file" {
    destination = "/tmp/startnode.yaml"
    content = <<EOF
region: ${var.deploy_region}
compartment_id: ${var.compartment_ocid}
vcn_id: ${oci_core_virtual_network.ClusterVCN.id}
ad_root: ${substr(
    oci_core_instance.ClusterManagement.availability_domain,
    0,
    length(oci_core_instance.ClusterManagement.availability_domain) - 1,
)}
ansible_branch: ${var.ansible_branch}
EOF

connection {
  timeout     = "15m"
  host        = oci_core_instance.ClusterManagement.public_ip
  user        = "opc"
  agent       = false
  private_key = "${var.private_key_pem}"
}
}

  provisioner "remote-exec" {
    inline = [
      "chmod a+x /tmp/ansible.sh",
      "/tmp/ansible.sh"
    ]
    connection {
      timeout     = "15m"
      host        = oci_core_instance.ClusterManagement.public_ip
      user        = "opc"
      private_key = "${var.private_key_pem}"
    }
  }

provisioner "remote-exec" {
  when = destroy
  inline = [
    "echo Terminating any remaining compute nodes",
    "if systemctl status slurmctld >> /dev/null; then",
    "sudo -u slurm /usr/local/bin/stopnode \"$(sinfo --noheader --Format=nodelist:10000 | tr -d '[:space:]')\" || true",
    "fi",
    "sleep 5",
    "echo Node termination request completed",
  ]

  connection {
    timeout     = "15m"
    host        = oci_core_instance.ClusterManagement.public_ip
    user        = "opc"
    agent       = false
    private_key = "${var.private_key_pem}"
  }
 }

}
