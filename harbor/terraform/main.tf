terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.50.0"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://server:8006/api2/json"
  insecure  = true
  api_token = "terraform@pam!tf=912c12d4-9c82-4cb4-a29d-bf34055fc790"
}

resource "proxmox_virtual_environment_vm" "harbor" {
  name        = "htest"
  node_name   = "pve"
  description = "Harbor test VM"

  disk {
    datastore_id = "local-lvm"
    size         = 10
    interface    = "scsi0"
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  network_device {
    bridge = "vmbr0"
  }

  agent {
    enabled = false
  }
}