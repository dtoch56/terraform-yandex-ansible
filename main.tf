locals {
  ansible_user = {
    name          = var.ansible_user_name
    uid           = var.ansible_user_uid
    gecos         = var.ansible_user_gecos
    hashed_passwd = var.ansible_user_hashed_passwd
    shell         = var.ansible_user_shell
    homedir       = var.ansible_user_homedir
    ssh_keys      = var.ansible_user_ssh_keys
  }

  boot_disk = {
    image_id = var.boot_disk_image_id
    size     = var.boot_disk_size
    type     = var.boot_disk_type
  }
}

resource "yandex_compute_instance" "ansible" {
  name        = var.name
  description = var.description
  folder_id   = var.folder_id
  labels      = var.labels
  zone        = var.zone
  hostname    = var.hostname
  metadata = merge({
    user-data = templatefile("${path.module}/template/ansible-user-data.tftpl", local.ansible_user)
  }, var.metadata)

  platform_id = var.platform_id

  allow_stopping_for_update = true

  scheduling_policy {
    preemptible = var.preemptible
  }

  resources {
    cores         = var.resources.cores
    memory        = var.resources.memory
    core_fraction = var.resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = local.boot_disk.image_id
      size     = local.boot_disk.size
      type     = local.boot_disk.type
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    ip_address         = try(var.ip_address, var.network.ip_address)
    ipv4               = var.network.ipv6
    ipv6_address       = try(var.ipv6_address, var.network.ipv6_address)
    ipv6               = var.network.ipv6
    nat                = true
    nat_ip_address     = yandex_vpc_address.ansible.external_ipv4_address.0.address
    security_group_ids = var.security_group_ids
    dynamic "dns_record" {
      for_each = var.network.dns
      content {
        fqdn        = (dns_record.value.fqdn == null ? "${var.hostname}.${dns_record.value.dns_zone}" : dns_record.value.fqdn)
        dns_zone_id = dns_record.value.zone_id
      }
    }
  }


  provisioner "remote-exec" {
    inline = ["hostname"]
    connection {
      type        = "ssh"
      host        = self.network_interface[0].nat_ip_address
      user        = "ansbl"
      private_key = file(var.bastion_ssh_key_private_file)
    }
  }

  provisioner "local-exec" {
    command = <<-EOT
ansible-playbook \
-u ansbl \
-i '${self.network_interface[0].nat_ip_address}' \
--private-key ${var.bastion_ssh_key_private_file} \
-e "ansible_become_pass=${var.ansible_become_pass}" \
-e "ansible_bastion_user=${var.ansible_user_name}" \
${path.module}/ansible/main.yml
EOT
  }
}

resource "yandex_vpc_address" "ansible" {
  name        = "ansible"
  description = "Ansible bastion"

  external_ipv4_address {
    zone_id                  = var.zone
    ddos_protection_provider = "qrator"
  }
}
