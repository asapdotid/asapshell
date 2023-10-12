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
alias g:cm='git_commit'
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
alias g:pl='git_pull'
alias g:ps='git_push'
alias g:ps:t='git_push_tag'
alias g:ps:ob='git_push_other_branch'
alias g:ps:db='git_push_delete_branch'
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
alias g:sh:s='git_stash_save'
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

# Functions
git_commit() {
  input "Commit message"
  read c_message
  if [ -z "$c_message" ]; then
    error "Please provide commit message"
    return 1
  fi
  git commit -m "$c_message"
}

git_pull() {
  git pull "${1:-origin}" "$(git symbolic-ref --short HEAD)"
}

git_push() {
  git push "${1:-origin}" "$(git symbolic-ref --short HEAD)"
}

git_push_tag() {
  git push "${1:-origin}" --tags
}

git_push_delete_branch() {
  input "Repository name (default: origin)"
  read r_name
  input "Branch target"
  read r_target
  if [ -z "$r_target" ]; then
    error "Please provide target branch"
    return 1
  fi
  git push "${r_name:-origin}" --delete --force "$r_target"
}

git_push_other_branch() {
  input "Repository name (default: origin)"
  read r_name
  input "Branch target"
  read r_target
  if [ -z "$r_target" ]; then
    error "Please provide target branch"
    return 1
  fi
  git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)":"$r_target"
}

git_stash_save() {
  git stash save "$1"
}

# Git taging
git_tagging() {
  input "Tag name"
  read t_name
  if [ -z "$t_name" ]; then
    error "Please provide tag name"
    return 1
  fi
  input "Tag message"
  read t_message
  if [ -z "$t_message" ]; then
    error "Please provide tag message"
    return 1
  fi
  git tag -a "$t_name" -m "${t_message}"
  git push origin "$(git symbolic-ref --short HEAD)" "$t_name"
}

# Get or pop out a specific stash in Git
# "n" refers to the number in the list
git_stash_apply_n() {
  git stash apply stash@"${1:-1}"
}

# Git delete all tags local and remote
git_delete_all_tags() {
  input "Are you sure delete all tags (y/n)?"
  read choice
  case "$choice" in
  y | Y)
    git tag -d "$(git tag -l)"
    git fetch
    git push "${1:-origin}" --delete "$(git tag -l)"
    git tag -d "$(git tag -l)"
    ;;
  *) return 1 ;;
  esac
}

# Git delete tag local and remote
git_delete_tag_local_remote() {
  input "Are you sure delete local and repository tag (y/n)?"
  read choice
  case "$choice" in
  y | Y)
    input "Repository (default: origin)"
    read t_repository
    input "Tag"
    read t_tag
    git tag -d "$t_tag" && git push "${t_repository:-origin}" :refs/tags/"${t_tag}"
    ;;
  *) return 1 ;;
  esac
}

# Git delete tag local
git_delete_tag_local() {
  input "Are you sure delete local tag (y/n)?"
  read choice
  case "$choice" in
  y | Y)
    input "Tag"
    read t_tag
    git tag -d "$t_tag"
    ;;
  *) return 1 ;;
  esac
}

# Git sync tags against a remote server
git_sync_tags() {
  git tag -l | xargs git tag -d && git fetch -t
}

# Git Commit, Add all and Push — in one step.
git_commit_push() {
  git add . && git commit -m "$2" && git push "${1:-origin}" "$(git symbolic-ref --short HEAD)"
}

# Git Commit, Add all — in one step.
git_commit() {
  git add . && git commit -m "$1"
}

# Git Merge
git_merge() {
  git merge --edit -m "🔀 MERGE: Branch $(git symbolic-ref --short HEAD) <-- from: $1" "$1"
}

# Git Merge
git_merge_no_ff() {
  git merge --no-ff --edit -m "🔀 MERGE: Branch $(git symbolic-ref --short HEAD) <-- from: $1" "$1"
}

### Better Git Logs.
### Using EMOJI-LOG (https://github.com/ahmadawais/Emoji-Log).
#### NEW.
git_new() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git Repository name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "📦 NEW: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "📦 NEW: $r_commit"
  fi
}

#### IMPROVE.
git_imp() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git repository name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "⚡️ IMPROVE: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "⚡️ IMPROVE: $r_commit"
  fi
}

#### FIX.
git_fix() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git repository name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🐛 FIX: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🐛 FIX: $r_commit"
  fi
}

#### RELEASE.
git_release() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git repository name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🔖 RELEASE: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🔖 RELEASE: $r_commit"
  fi
}

#### DEPLOY.
git_deploy() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🚀 DEPLOY: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array $r_files)
    git add "$__add_files" && git commit -m "🚀 DEPLOY: $r_commit"
  fi
}

#### FIX CI.
git_fix_ci() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "💚 FIX CI: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "💚 FIX CI: $r_commit"
  fi
}

#### DOC.
git_doc() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git repository name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "📖 DOC: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "📖 DOC: $r_commit"
  fi
}

#### TEST.
git_test() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git repository name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🧪 TEST: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🧪 TEST: $r_commit"
  fi
}

#### BREAKING CHANGE.
git_break() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git repository name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "‼️ BREAKING: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "‼️ BREAKING: $r_commit"
  fi
}

#### REMOVE CODE/FILES.
git_remove() {
  local __remove_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🔥 REMOVE: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __remove_files=$(helper_array "$r_files")
    git add "$__remove_files" && git commit -m "🔥 REMOVE: $r_commit"
  fi
}

#### CRITICAL HOTFIX.
git_hotfix() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🚑 CRITICAL HOTFIX: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🚑 HOTFIX: $r_commit"
  fi
}

#### NEW FEATURE.
git_feature() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "✨ NEW FEATURE: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "✨ NEW FEATURE: $r_commit"
  fi
}

#### ADD/UPDATE.
git_add_update() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "✅ ADD/UPDATE: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "✅ ADD/UPDATE: $r_commit"
  fi
}

#### FIX SECURITY.
git_fix_security() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🔒️ FIX SECURITY: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🔒️ FIX SECURITY: $r_commit"
  fi
}

#### ADD/UPDATE SECRET.
git_add_update_secret() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🔐 ADD/UPDATE SECRET: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🔐 ADD/UPDATE SECRET: $r_commit"
  fi
}

#### WORKING IN PROGRESS.
git_wip() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🚧 WIP: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🚧 WIP: $r_commit"
  fi
}

#### RFACTOR CODE
git_refactor_code() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "♻️ REFACTOR: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "♻️ REFACTOR: $r_commit"
  fi
}

#### CONFIG
git_config() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🔧 CONFIG: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🔧 CONFIG: $r_commit"
  fi
}

#### TYPOS
git_typos() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "✏️ FIX TYPOS: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "✏️ FIX TYPOS: $r_commit"
  fi
}

#### ADD/UPDATE LICENSE
git_license() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "📄 LICENSE: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "📄 LICENSE: $r_commit"
  fi
}

#### ADD/UPDATE ASSETS
git_assets() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🍱 ASSETS: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🍱 ASSETS: $r_commit"
  fi
}

#### ADD/UPDATE ASSETS
git_assets() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🍱 ASSETS: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🍱 ASSETS: $r_commit"
  fi
}

#### DEPRECETED
git_depreceted() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🗑️ DEPRECETED: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🗑️ DEPRECETED: $r_commit"
  fi
}

#### TEXT
git_text() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "💬 TEXT: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "💬 TEXT: $r_commit"
  fi
}

#### COMMENTS
git_comments() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "💡 COMMENTS: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "💡 COMMENTS: $r_commit"
  fi
}

#### DEVELOP
git_develop() {
  local __add_files
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Remote name"
    read r_name
    if [ -z "$r_name" ]; then
      error "Please provide git remote name"
      return 1
    fi
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🔨 DEVELOPMENT: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read r_files
    input "Commit message"
    read r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    __add_files=$(helper_array "$r_files")
    git add "$__add_files" && git commit -m "🔨 DEVELOPMENT: $r_commit"
  fi
}
