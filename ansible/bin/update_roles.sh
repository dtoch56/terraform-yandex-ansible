#!/bin/bash

ansible-galaxy role install --force dtoch56.upgrade_packages
ansible-galaxy role install --force dtoch56.prepare_host
ansible-galaxy role install --force dtoch56.ssh

ansible-galaxy role install --force dtoch56.test

