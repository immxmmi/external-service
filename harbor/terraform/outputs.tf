output "vm_id" {
  description = "The ID of the VM"
  value       = proxmox_virtual_environment_vm.harbor.id
}

output "vm_name" {
  description = "Name of the VM"
  value       = proxmox_virtual_environment_vm.harbor.name
}

output "proxmox_node" {
  description = "Node where the VM is running"
  value       = proxmox_virtual_environment_vm.harbor.node_name
}

output "vm_cpu_cores" {
  description = "Allocated CPU cores"
  value       = proxmox_virtual_environment_vm.harbor.cpu[0].cores
}

output "vm_memory_mb" {
  description = "Allocated RAM in MB"
  value       = proxmox_virtual_environment_vm.harbor.memory[0].dedicated
}

output "vm_disk_size_gb" {
  description = "VM Disk size in GB"
  value       = proxmox_virtual_environment_vm.harbor.disk[0].size
}