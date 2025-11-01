resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.vm_name
  node_name   = var.node_name
  description = var.vm_description

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
    enabled = false
  }
}