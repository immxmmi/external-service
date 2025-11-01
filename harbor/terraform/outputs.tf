# ─────────────────────────────
# VM Identification
# ─────────────────────────────
output "vm_id" {
  description = "The ID of the VM"
  value       = proxmox_virtual_environment_vm.vm.id
}

output "vm_name" {
  description = "Name of the VM"
  value       = proxmox_virtual_environment_vm.vm.name
}

output "proxmox_node" {
  description = "Node where the VM is running"
  value       = proxmox_virtual_environment_vm.vm.node_name
}

# ─────────────────────────────
# VM Hardware Configuration
# ─────────────────────────────
output "vm_cpu_cores" {
  description = "Allocated CPU cores"
  value       = proxmox_virtual_environment_vm.vm.cpu[0].cores
}

output "vm_memory_mb" {
  description = "Allocated RAM in MB"
  value       = proxmox_virtual_environment_vm.vm.memory[0].dedicated
}

output "vm_disk_size_gb" {
  description = "VM Disk size in GB"
  value       = proxmox_virtual_environment_vm.vm.disk[0].size
}

# ─────────────────────────────
# Networking
# ─────────────────────────────
output "vm_ip" {
  description = "Primary IPv4 address of the VM"
  value       = proxmox_virtual_environment_vm.vm.ipv4_addresses[0]
}

output "vm_tags" {
  description = "Applied tags for the VM"
  value       = proxmox_virtual_environment_vm.vm.tags
}