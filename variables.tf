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

variable "subnet_id" {
  description = ""
  type = string
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
    image_id = number
    size     = number
    type     = number
  })
  default = {
    image_id = null
    size     = 15
    type     = "network-hdd"
  }
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


variable "ansible_user" {
  description = "Ansible user for the bastion"
  type = object({
    name          = string
    uid           = number
    gecos         = string
    hashed_passwd = string
    shell         = string
    homedir       = string
    ssh_keys      = list(string)
  })
  default = {
    name          = "ansbl"
    uid           = 1099
    gecos         = "Ansible user"
    hashed_passwd = null
    shell         = "/bin/bash"
    homedir       = "/home/ansbl"
    ssh_keys      = []
  }
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
