proxmox_api_url   = "https://server:8006/api2/json"
proxmox_api_token = "terraform@pam!tf=912c12d4-9c82-4cb4-a29d-bf34055fc790"

vm_name              = "vm"
vm_description      = "Harbor test VM"
vm_tags = ["harbor", "linux", "managed-by-terraform"]
node_name            = "pve"
vm_cores             = 2
vm_memory            = 4096
vm_disk_size         = 10
vm_disk_datastore    = "local-lvm"
vm_bridge            = "vmbr0"

vm_initial_user    = "momo"
vm_initial_ssh_key = "./ssh/id_rsa.pub"