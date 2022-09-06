output "ip" {
  description = "Ansible bastion IP address"
  value       = yandex_compute_instance.ansible.network_interface[0].nat_ip_address
}

output "port" {
  description = "Ansible bastion SSH port"
  value       = var.bastion_ssh_port
}

output "user" {
  description = "Ansible bastion user"
  value       = var.ansible_user_name
}
