## 📌 File Overview and Explanations

This Terraform project is modularly designed to automate Proxmox VMs in a flexible and reusable way.

| File | Purpose |
|------|---------|
| **providers.tf** | Contains provider configuration (Proxmox API endpoint & token). Defined once for the entire project. |
| **main.tf** | Entry point for Terraform. Can remain minimal if resources are organized in separate files. |
| **vm.tf** | Defines the virtual machine (CPU, RAM, storage, network, settings). Can be reused multiple times. |
| **variables-provider.tf** | Variables for provider configuration (API URL & token). Token must never be written directly into a `.tf` file! |
| **variables-vm.tf** | Variables for VM specifications such as CPU, RAM, datastore, VM name, etc. |
| **variables-network.tf** | Network variables such as bridge, VLAN, static IP settings. |
| **variables-cloudinit.tf** | Cloud-init configuration (username, SSH keys, initial password, etc.). |
| **outputs.tf** | Outputs relevant data after deployment (e.g. VM ID, VM name, IP address). |
| **terraform.tfvars** | Values for all environment-specific variables. **Important: Do not commit!** |
| **environments/*.tfvars** | Alternative environment definitions (e.g. homelab, prod, test). Selectable using `-var-file`. |

---

## ✅ Deployment Example

For your homelab environment:

```bash
terraform apply -var-file="environments/homelab.tfvars"
```

---

## 🔐 Security Guidelines

⚠️ Important rules:
- Never commit the API token
- Add `terraform.tfvars` to `.gitignore`
- If multiple environments exist → one tfvars file per environment

---

## 🚀 Next Steps

This project is easily extendable, e.g.:
- Enable Cloud-Init
- Automate Ubuntu installation
- Convert VM into a reusable template
- Deploy additional services (e.g. Harbor, GitLab, Vault, etc.)

If you have questions → the file structure makes it easy to grow and automate your infrastructure ✅