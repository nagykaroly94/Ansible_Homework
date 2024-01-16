#!/bin/bash

sudo su

print_line() {
  echo "========================"
}

print_line
echo "Install pip"
yum install pip -y


print_line
echo "Install pipx"
python3 -m pip install --user pipx
python3 -m pipx ensurepath


print_line
echo "Install ansible"
pipx install --include-deps ansible


print_line
echo "Verify ansible"
ansible --version


print_line
echo "Add shell completion of the Ansible"
pipx inject --include-apps ansible argcomplete
activate-global-python-argcomplete --user


print_line
echo "Install sshpass"
yum install sshpass -y