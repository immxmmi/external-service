terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.50.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  insecure  = true
  api_token = var.proxmox_api_token
}

resource "proxmox_virtual_environment_vm" "harbor" {
  name        = var.vm_name
  node_name   = var.node_name
  description = "Harbor test VM"

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