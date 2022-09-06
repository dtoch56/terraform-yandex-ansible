variable "name" {
  description = "Bastion name"
  type        = string
  default     = "ansible"
}

variable "description" {
  description = "Bastion description"
  type        = string
  default     = "Ansible bastion"
}

variable "folder_id" {
  description = "The ID of the folder that the bastion belongs to."
  type        = string
}

variable "network_id" {
  description = ""
  type        = string
}

variable "subnet_id" {
  description = ""
  type        = string
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the bastion instance."
  type        = map(string)
  default     = {}
}

variable "hostname" {
  description = "Host name for the instance."
  type        = string
  default     = null
}

variable "zone" {
  description = "The availability zone where the virtual machine will be created."
  type        = string
}


variable "metadata" {
  description = "Metadata key/value pairs to make available from within the instance."
  type        = map(string)
  default     = {}
}


variable "platform_id" {
  description = "The type of virtual machine to create."
  type        = string
  default     = "standard-v1"
}


variable "preemptible" {
  description = <<-EOF
  Specifies if the instance is preemptible.
  A VM that runs for no more than 24 hours and can be terminated by Yandex Cloud at any time.
  Terminated VMs aren’t deleted and all the data they contain is maintained.
  To continue using a VM, restart it. Provided at a significant discount.
  EOF
  type        = bool
  default     = true
}



variable "resources" {
  description = "Compute resources that are allocated for the instance."
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}

variable "boot_disk" {
  description = "The boot disk for the instance."
  type = object({
    image_id = string
    size     = number
    type     = string
  })
  default = {
    image_id = null
    size     = 15
    type     = "network-hdd"
  }
}

# The boot disk for the instance.
variable "boot_disk_image_id" {
  description = ""
  type        = string
}

variable "boot_disk_size" {
  description = ""
  type        = string
  default     = 15
}

variable "boot_disk_type" {
  description = ""
  type        = string
  default     = "network-hdd"
}


variable "network" {
  description = "Networks to attach to the instance."
  type = object({
    ipv4         = bool
    ip_address   = string
    ipv6         = bool
    ipv6_address = string
    dns = list(object({
      zone_id  = string
      fqdn     = string
      dns_zone = string
    }))
  })
  default = {
    ipv4         = true
    ip_address   = null
    ipv6         = false
    ipv6_address = null
    dns          = []
  }
}

# Ansible user for the bastion
variable "ip_address" {
  description = "Ansible bastion IP address"
  type        = string
  default     = null
}

variable "ipv6_address" {
  description = "Ansible bastion IPV6 address"
  type        = string
  default     = null
}


# Ansible user for the bastion
variable "ansible_user_name" {
  description = "Ansible user name"
  type        = string
  default     = "ansbl"
}

variable "ansible_user_uid" {
  description = "Ansible user uid"
  type        = number
  default     = 1099
}

variable "ansible_user_gecos" {
  description = "Ansible user name"
  type        = string
  default     = "Ansible user GECOS field"
}

variable "ansible_user_hashed_passwd" {
  description = "Ansible user hashed password"
  type        = string
}

variable "ansible_user_shell" {
  description = "Ansible user shell path"
  type        = string
  default     = "/bin/bash"
}

variable "ansible_user_homedir" {
  description = "Ansible user home directory path"
  type        = string
  default     = "/home/ansbl"
}

variable "ansible_user_ssh_keys" {
  description = "Ansible user list of public ssh keys"
  type        = list(string)
}




variable "default_security_groups" {
  description = "Create default security groups for Ansible bastion"
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "A set of ids of security groups assigned to Ansible bastion."
  type        = set(string)
  default     = []
}

variable "whitelist_ips" {
  description = "List of Whitelist IPs to access Ansible bastion"
  type        = list(string)
}


variable "ansible_become_pass" {
  description = ""
  type = string
}

variable "bastion_ssh_key_private_file" {
  description = ""
  type = string
}

variable "bastion_ssh_port" {
  description = "SSH port"
  type = number
  default = 38721
}