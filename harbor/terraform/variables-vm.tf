variable "vm_name" {
  type        = string
  description = "Name of the VM"
}

variable "vm_description" {
  type        = string
  description = "Description of the VM"
}

variable "node_name" {
  type        = string
  description = "Proxmox node name"
}

variable "vm_cores" {
  type        = number
  description = "Number of CPU cores"
}

variable "vm_memory" {
  type        = number
  description = "VM memory in MB"
}

variable "vm_disk_size" {
  type        = number
  description = "Disk size in GB"
}

variable "vm_disk_datastore" {
  type        = string
  description = "Datastore for VM disk"
}