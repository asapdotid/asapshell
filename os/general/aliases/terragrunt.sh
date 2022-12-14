#!/bin/bash
# Terragrunt
alias tg='terragrunt'
alias tg:-v='terragrunt --version'
alias tg:p='terragrunt plan'
alias tg:ra:p='terragrunt run-all plan'
alias tg:a='terragrunt apply'
alias tg:ra:a='terragrunt run-all apply'
alias tg:o='terragrunt output'
alias tg:ra:o='terragrunt run-all output'
alias tg:d='terragrunt destroy'
alias tg:ra:d='terragrunt run-all destroy'
alias tg:v='terragrunt validate'
alias tg:ra:v='terragrunt run-all validate'
alias tg:tgi='terragrunt terragrunt-info'
alias tg:vi='terragrunt validate-inputs'
alias tg:gd='terragrunt graph-dependencies'
alias tg:f='terragrunt hclfmt'
