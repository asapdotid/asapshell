#!/bin/bash
# Ansible
alias a='ansible'
alias a:-v='ansible --version'
alias a:l='ansible --list-hosts all'
alias a:new='new_ansible'
alias ap='ansible-playbook'
# Ansible Galaxy
alias ag='ansible-galaxy'
alias ag:l='ansible-galaxy list'
alias ag:i='ansible-galaxy install'
alias ag:r='ansible-galaxy install'
alias ag:s='ansible-galaxy search'
alias ag:init='ansible-galaxy init'
# Ansible Vault
alias av='ansible-vault'
alias av:c='ansible-vault create'
alias av:e='ansible-vault encrypt'
alias av:d='ansible-vault decrypt'
alias av:v='ansible-vault view'

## Functions
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
    mkdir -p inventories/$i/{group_vars,host_vars}
    touch inventories/$i/hosts
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
