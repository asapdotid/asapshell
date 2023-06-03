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
alias g:mr='git_merge'
alias g:mr:n='git_merge_no_ff'
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
alias g:t:dlr='git_delete_tag_local_remote'
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
alias g:ui:untrack='git update-index --assume-unchanged'
alias g:ui:track='git update-index --no-assume-unchanged'
alias g:rm:cached='git rm -r --cached --ignore-unmatch'
# Git Commit with Emoji
alias g:new='git_new'
alias g:imp='git_imp'
alias g:fix='git_fix'
alias g:rel='git_release'
alias g:doc='git_doc'
alias g:test='git_test'
alias g:break='git_break'
alias g:remove='git_remove'
alias g:hotfix='git_hotfix'
alias g:feature='git_feature'
alias g:deploy='git_deploy'
alias g:ci='git_fix_ci'
alias g:security='git_fix_security'
alias g:secret='git_add_update_secret'
alias g:wip='git_wip'
alias g:conf='git_config'
alias g:lic='git_license'
alias g:asset='git_assets'
alias g:depreceted='git_depreceted'
alias g:text='git_text'
alias g:comment='git_comments'
alias g:develop='git_develop'
# Git Push with Emoji
alias g:new:p='git_new --push'
alias g:imp:p='git_imp --push'
alias g:fix:p='git_fix --push'
alias g:rel:p='git_release --push'
alias g:doc:p='git_doc --push'
alias g:test:p='git_test --push'
alias g:break:p='git_break --push'
alias g:remove:p='git_remove --push'
alias g:hotfix:p='git_hotfix --push'
alias g:feature:p='git_feature --push'
alias g:deploy:p='git_deploy --push'
alias g:ci:p='git_fix_ci --push'
alias g:security:p='git_fix_security --push'
alias g:secret:p='git_add_update_secret --push'
alias g:wip:p='git_wip --push'
alias g:conf:p='git_config --push'
alias g:lic:p='git_license --push'
alias g:asset:p='git_assets --push'
alias g:depreceted:p='git_depreceted --push'
alias g:text:p='git_text --push'
alias g:comment:p='git_comments --push'
alias g:develop:p='git_develop --push'

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
  read -p "Are you sure (y/n)?" choice
  case "$choice" in
  y | Y)
    git tag -d $(git tag -l)
    git fetch
    git push ${1:-origin} --delete $(git tag -l)
    git tag -d $(git tag -l)
    break
    ;;
  n | N) exit ;;
  *) error "invalid" ;;
  esac
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
function git_commit_push() {
  git add . && git commit -m "$2" && git push ${1:-origin} "$(git symbolic-ref --short HEAD)"
}

# Git Commit, Add all — in one step.
function git_commit() {
  git add . && git commit -m "$1"
}

# Git Merge
function git_merge() {
  git merge --edit -m "🔀 MERGE: Branch $(git symbolic-ref --short HEAD) <-- from: $1" $1
}

# Git Merge
function git_merge_no_ff() {
  git merge --no-ff --edit -m "🔀 MERGE: Branch $(git symbolic-ref --short HEAD) <-- from: $1" $1
}

### Better Git Logs.
### Using EMOJI-LOG (https://github.com/ahmadawais/Emoji-Log).
#### NEW.
function git_new() {
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
function git_imp() {
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
    git add . && git commit -m "⚡️ IMPROVE: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "⚡️ IMPROVE: $r_commit"
  fi
}

#### FIX.
function git_fix() {
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
function git_release() {
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
    git add . && git commit -m "🔖 RELEASE: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🔖 RELEASE: $r_commit"
  fi
}

#### DEPLOY.
function git_deploy() {
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
    git add . && git commit -m "🚀 DEPLOY: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🚀 DEPLOY: $r_commit"
  fi
}

#### FIX CI.
function git_fix_ci() {
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
    git add . && git commit -m "💚 FIX CI: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "💚 FIX CI: $r_commit"
  fi
}

#### DOC.
function git_doc() {
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
function git_test() {
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
    git add . && git commit -m "🧪 TEST: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🧪 TEST: $r_commit"
  fi
}

#### BREAKING CHANGE.
function git_break() {
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

#### REMOVE CODE/FILES.
function git_remove() {
  local __remove_files
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
    git add . && git commit -m "🔥 REMOVE: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please give git commit message"
      return 1
    fi
    __remove_files=$(helper_array $r_files)
    git add "$__remove_files" && git commit -m "🔥 REMOVE: $r_commit"
  fi
}

#### CRITICAL HOTFIX.
function git_hotfix() {
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
    git add . && git commit -m "🚑 CRITICAL HOTFIX: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🚑 HOTFIX: $r_commit"
  fi
}

#### NEW FEATURE.
function git_feature() {
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
    git add . && git commit -m "✨ NEW FEATURE: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "✨ NEW FEATURE: $r_commit"
  fi
}

#### ADD/UPDATE.
function git_add_update() {
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
    git add . && git commit -m "✅ ADD/UPDATE: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "✅ ADD/UPDATE: $r_commit"
  fi
}

#### FIX SECURITY.
function git_fix_security() {
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
    git add . && git commit -m "🔒️ FIX SECURITY: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🔒️ FIX SECURITY: $r_commit"
  fi
}

#### ADD/UPDATE SECRET.
function git_add_update_secret() {
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
    git add . && git commit -m "🔐 ADD/UPDATE SECRET: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🔐 ADD/UPDATE SECRET: $r_commit"
  fi
}

#### WORKING IN PROGRESS.
function git_wip() {
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
    git add . && git commit -m "🚧 WIP: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🚧 WIP: $r_commit"
  fi
}

#### RFACTOR CODE
function git_refactor_code() {
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
    git add . && git commit -m "♻️ REFACTOR: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "♻️ REFACTOR: $r_commit"
  fi
}

#### CONFIG
function git_config() {
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
    git add . && git commit -m "🔧 CONFIG: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🔧 CONFIG: $r_commit"
  fi
}

#### TYPOS
function git_typos() {
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
    git add . && git commit -m "✏️ FIX TYPOS: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "✏️ FIX TYPOS: $r_commit"
  fi
}

#### ADD/UPDATE LICENSE
function git_license() {
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
    git add . && git commit -m "📄 LICENSE: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "📄 LICENSE: $r_commit"
  fi
}

#### ADD/UPDATE ASSETS
function git_assets() {
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
    git add . && git commit -m "🍱 ASSETS: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🍱 ASSETS: $r_commit"
  fi
}

#### ADD/UPDATE ASSETS
function git_assets() {
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
    git add . && git commit -m "🍱 ASSETS: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🍱 ASSETS: $r_commit"
  fi
}

#### DEPRECETED
function git_depreceted() {
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
    git add . && git commit -m "🗑️ DEPRECETED: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🗑️ DEPRECETED: $r_commit"
  fi
}

#### TEXT
function git_text() {
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
    git add . && git commit -m "💬 TEXT: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "💬 TEXT: $r_commit"
  fi
}

#### COMMENTS
function git_comments() {
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
    git add . && git commit -m "💡 COMMENTS: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "💡 COMMENTS: $r_commit"
  fi
}

#### DEVELOP
function git_develop() {
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
    git add . && git commit -m "🔨 DEVELOPMENT: $r_commit" && git push ${r_name:-origin} "$(git symbolic-ref --short HEAD)"
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
    git add "$__add_files" && git commit -m "🔨 DEVELOPMENT: $r_commit"
  fi
}
