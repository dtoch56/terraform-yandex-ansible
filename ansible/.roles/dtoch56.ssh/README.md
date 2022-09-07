ssh-role
=========

[![CI](https://github.com/dtoch56/ansible-role-ssh/workflows/CI/badge.svg?event=push)](https://github.com/dtoch56/ansible-role-ssh/actions?query=workflow%3ACI)


SSH Server and client configuration

Based on Mozilla InfoSec recommendations: https://infosec.mozilla.org/guidelines/openssh.html

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see defaults/main.yml):

| Variable         | Description                                         | Default  |
| ---------------- |:--------------------------------------------------- |:-------- |
| ssh_port         | Ssh-server listening port                           | 22       |
| ssh_ansible_user | Account for Ansible                                 | ansible  |
| ssh_users        | List of accounts to accept incoming SSH connections | {}       |


Dependencies
------------

None.

Example Playbook
----------------

    - hosts: servers
      roles:
        - { role: dtoch56.ssh }

License
-------

MIT / BSD

Author Information
------------------

This role was created in 2021 by Max Mudrichenko.

Development
------------------

    pip install pipenv
    pipenv install
