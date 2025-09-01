#!/usr/bin/env bash
# Ansible
alias an='ansible'
alias an:-v='ansible --version'
alias an:-h='ansible --help'
alias an:lh='ansible --list-hosts all'
alias an:new='new_ansible'
alias anp='ansible-playbook'
# Ansible Galaxy
alias ang='ansible-galaxy'
alias ang:-h='ansible-galaxy --help'
alias ang:l='ansible-galaxy list'
alias ang:i='ansible-galaxy install'
alias ang:r='ansible-galaxy install'
alias ang:s='ansible-galaxy search'
alias ang:init='ansible-galaxy init'
# Ansible Vault
alias anv='ansible-vault'
alias anv:-h='ansible-vault --help'
alias anv:c='ansible-vault create'
alias anv:e='ansible-vault encrypt'
alias anv:d='ansible-vault decrypt'
alias anv:v='ansible-vault view'

# Functions
new_ansible() {
  info "Ansible initial project:"
  info "1. Staging"
  info "2. Production"
  info "3. Staging & Production"
  info "4. Staging, Production & Development"
  PS3="Which Ansible project do you want use? [1, 2, 3, 4] : "
  # read -r -p "Which Ansible project do you want use? [1, 2, 3, 4] : " opt
  select opt in 1 2 3 4; do
    case $opt in
    1)
      ansible_project_init "staging"
      break
      ;;
    2)
      ansible_project_init "production"
      break
      ;;
    3)
      ansible_project_init "staging" "production"
      break
      ;;
    4)
      ansible_project_init "staging" "production" "development"
      break
      ;;
    quit)
      break
      ;;
    *)
      error "Invalid option $REPLY"
      ;;
    esac
  done
}

ansible_project_init() {
  for i; do
    info "Create inventory $i"
    mkdir -p "inventories/$i/{group_vars,host_vars}"
    touch "inventories/$i/hosts"
  done
  info "Create directory group_vars host_vars library module_utils filter_plugins"
  mkdir -p group_vars host_vars library module_utils filter_plugins
  info "Create Roles directory"
  mkdir -p roles/.keepfile
  info "Create Collection directory"
  mkdir -p collections/.keepfile
  info "Create site.yml"
  touch site.yml
  info "Create Ansible config"
  touch ansible.cfg
  info "Create yamllint"
  touch .yamllint
  info "Create gitignore"
  touch .gitignore
  info "Initial git"
  git init
  info Directory project
  tree . -LCa 4 -I .git
  info "Done..."
  info "You can add some files manualy on project. Ready to bake!"
}
