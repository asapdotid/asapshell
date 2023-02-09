#!/bin/bash
# Git Command Alises #
alias g='git'
alias g:-v='git --version'
alias g:-h='git --help'
alias g:i='git init'
alias g:s='git status'
alias g:a.='git add .'
alias g:aa='git add -All'
alias g:b='git branch'
alias g:b:d='git branch -d'
alias g:cl='git clone'
alias g:cm='function _gcommit(){ git commit -m $1 };_gcommit'
alias g:co='git checkout'
alias g:co:b='git checkout -b'
alias g:d:c='git rm -r --cached'
alias g:f='git fetch'
alias g:f:a='git fetch --all'
alias g:mr='git merge'
alias g:mr:n='git merge --no-ff --no-commit'
alias g:r:a='git remote add'
alias g:r:r='git remote rm'
alias g:r:v='git remote -v'
alias g:r:n='git remote set-url'
alias g:pull='function _gpull(){ git pull ${1:-origin} "$(git symbolic-ref --short HEAD)" };_gpull'
alias g:push='function _gpush(){ git push ${1:-origin} "$(git symbolic-ref --short HEAD)" };_gpush'
alias g:push:t='function _gpushtag(){ git push ${1:-origin} --tags };_gpushtag'
alias g:push:db='function _gpushbranchdelete(){ git push $1 --delete --force $2 };_gpushbranchdelete'
alias g:t='git tag'
alias g:t:dl='git_delete_tag_local'
alias g:t:dr='git_delete_tag_local_remote'
alias g:t:da='git_delete_all_tags'
alias g:t:sync='git_sync_tags'
alias g:tag='git_tagging'
alias g:sh='git stash'
alias g:sh:l='git stash list'
alias g:sh:sh='git stash show'
alias g:sh:a='git stash apply'
alias g:sh:an='git_stash_apply_n'
alias g:sh:p='git stash pop'
alias g:sh:c='git stash clear'
alias g:sh:s='function _gstashsave(){ git stash save $1 };_gstashsave'
# Git with Emoji
alias g:new='gnew'
alias g:imp='gimp'
alias g:fix='gfix'
alias g:rls='grls'
alias g:doc='gdoc'
alias g:tst='gtst'
alias g:brk='gbrk'
# Git with Emoji with Push
alias g:new:p='gnew --push'
alias g:imp:p='gimp --push'
alias g:fix:p='gfix --push'
alias g:rls:p='grls --push'
alias g:doc:p='gdoc --push'
alias g:tst:p='gtst --push'
alias g:brk:p='gbrk --push'

## Functions
# Git taging
git_tagging() {
  git tag -a $1 -m "${2}"
  git push origin "$(git symbolic-ref --short HEAD)" $1
}

# Get or pop out a specific stash in Git
# "n" refers to the number in the list
git_stash_apply_n() {
  git stash apply stash@{$1}
}

# Git delete all tags local and remote
git_delete_all_tags() {
  git tag -d $(git tag -l)
  git fetch
  git push ${1:-origin} --delete $(git tag -l)
  git tag -d $(git tag -l)
}

# Git delete tag local and remote
function git_delete_tag_local_remote() {
  git tag -d "$2" && git push ${1:-origin} :refs/tags/${2}
}

# Git delete tag local
function git_delete_tag_local() {
  git tag -d "$1"
}

# Git sync tags against a remote server
function git_sync_tags() {
  git tag -l | xargs git tag -d && git fetch -t
}

# Git Commit, Add all and Push — in one step.
function gcap() {
  git add . && git commit -m "$2" && git push ${1:-origin} "$(git symbolic-ref --short HEAD)"
}

# Git Commit, Add all — in one step.
function gca() {
  git add . && git commit -m "$1"
}

### Better Git Logs.
### Using EMOJI-LOG (https://github.com/ahmadawais/Emoji-Log).
#### NEW.
function gnew() {
  local __add_files
  if [[ -n "$1" && $1 == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please give git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    git add . && git commit -m "📦 NEW: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    __add_files=$(helper_array $r_files)
    git add "$__add_files" && git commit -m "📦 NEW: $r_commit"
  fi
}

#### IMPROVE.
function gimp() {
  local __add_files
  if [[ -n "$1" && $1 == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please give git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    git add . && git commit -m "👌 IMPROVE: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    __add_files=$(helper_array $r_files)
    git add "$__add_files" && git commit -m "👌 IMPROVE: $r_commit"
  fi
}

#### FIX.
function gfix() {
  local __add_files
  if [[ -n "$1" && $1 == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please give git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    git add . && git commit -m "🐛 FIX: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    __add_files=$(helper_array $r_files)
    git add "$__add_files" && git commit -m "🐛 FIX: $r_commit"
  fi
}

#### RELEASE.
function grls() {
  local __add_files
  if [[ -n "$1" && $1 == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please give git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    git add . && git commit -m "🚀 RELEASE: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    __add_files=$(helper_array $r_files)
    git add "$__add_files" && git commit -m "🚀 RELEASE: $r_commit"
  fi
}

#### DOC.
function gdoc() {
  local __add_files
  if [[ -n "$1" && $1 == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please give git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    git add . && git commit -m "📖 DOC: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    __add_files=$(helper_array $r_files)
    git add "$__add_files" && git commit -m "📖 DOC: $r_commit"
  fi
}

#### TEST.
function gtst() {
  local __add_files
  if [[ -n "$1" && $1 == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please give git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    git add . && git commit -m "🤖 TEST: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    __add_files=$(helper_array $r_files)
    git add "$__add_files" && git commit -m "🤖 TEST: $r_commit"
  fi
}

#### BREAKING CHANGE.
function gbrk() {
  local __add_files
  if [[ -n "$1" && $1 == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please give git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    git add . && git commit -m "‼️ BREAKING: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    __add_files=$(helper_array $r_files)
    git add "$__add_files" && git commit -m "‼️ BREAKING: $r_commit"
  fi
}
