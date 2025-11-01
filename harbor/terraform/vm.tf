resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.vm_name
  node_name   = var.node_name
  description = var.vm_description
  tags        = var.vm_tags

  disk {
    datastore_id = var.vm_disk_datastore
    size         = var.vm_disk_size
    interface    = "scsi0"
  }

  cpu {
    cores = var.vm_cores
  }

  memory {
    dedicated = var.vm_memory
  }

  network_device {
    bridge = var.vm_bridge
  }

  agent {
    enabled = true
  }

    initialization {
    datastore_id = var.vm_disk_datastore
    type         = "nocloud"

    user_account {
        username = var.vm_initial_user
        keys     = [file(var.vm_initial_ssh_key)]
    }
    }
}