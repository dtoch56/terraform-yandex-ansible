resource "yandex_vpc_security_group" "ansible" {
  count = var.default_security_groups ? 1 : 0

  name        = "ansible-bastion"
  description = ""
  folder_id   = var.folder_id
  network_id  = var.network_id

  ingress {
    description    = "SSH"
    protocol       = "TCP"
    port           = var.bastion_ssh_port
    v4_cidr_blocks = var.whitelist_ips
  }
  egress {
    description    = "All outgoing traffic"
    protocol       = "Any"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}