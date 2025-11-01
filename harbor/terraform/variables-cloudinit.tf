variable "vm_initial_user" {
  type        = string
  description = "Initial VM username created via Cloud-Init"
}

variable "vm_initial_ssh_key" {
  type        = string
  description = "Path to the SSH public key file used for initial provisioning"
}