#!/usr/bin/env bash
# Git Command Alises #
alias g='git'
alias g:-v='git --version'
alias g:-h='git --help'
alias g:i='git init'
alias g:s='git status'
alias g:clean='git clean -fd'
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
alias g:n='git_new'
alias g:ft='git_feat'
alias g:pe='git_performance'
alias g:fi='git_fix'
alias g:ch='git_chore'
alias g:re='git_release'
alias g:dc='git_doc'
alias g:te='git_test'
alias g:ci='git_ci'
alias g:rf='git_refactor'
alias g:st='git_style'
alias g:bl='git_build'
alias g:rv='git_revert'

# Git Push with Emoji
alias g:n:p='git_new --push'
alias g:ft:p='git_feat --push'
alias g:pe:p='git_performance --push'
alias g:fi:p='git_fix --push'
alias g:ch:p='git_chore --push'
alias g:dc:p='git_doc --push'
alias g:test:p='git_test --push'
alias g:ci:p='git_ci --push'
alias g:rf:p='git_refactor --push'
alias g:rl:p='git_release --push'
alias g:st:p='git_style --push'
alias g:bl:p='git_build --push'
alias g:rv:p='git_revert --push'

# Functions
# Git string array helper
git_add_files_commit() {
  local files=$1
  local commit=$2

  if [ -z "$files" ] && [ -z "$commit" ]; then
    error "Please provide target files and commit message"
    return 1
  fi

  for v in $(tr ',' '\n' <<<"$files"); do git add "$v" && git commit -m "$commit"; done
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
  input "Repository name (default: origin) (default: origin)"
  read -r r_name
  input "Branch target"
  read -r r_target
  if [ -z "$r_target" ]; then
    error "Please provide target branch"
    return 1
  fi
  git push "${r_name:-origin}" --delete --force "$r_target"
}

git_push_other_branch() {
  input "Repository name (default: origin) (default: origin)"
  read -r r_name
  input "Branch target"
  read -r r_target
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
  read -r t_name
  if [ -z "$t_name" ]; then
    error "Please provide tag name"
    return 1
  fi
  input "Tag message"
  read -r t_message
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
  read -r choice
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
  read -r choice
  case "$choice" in
  y | Y)
    input "Repository (default: origin)"
    read -r t_repository
    input "Tag"
    read -r t_tag
    git tag -d "$t_tag" && git push "${t_repository:-origin}" :refs/tags/"${t_tag}"
    ;;
  *) return 1 ;;
  esac
}

# Git delete tag local
git_delete_tag_local() {
  input "Are you sure delete local tag (y/n)?"
  read -r choice
  case "$choice" in
  y | Y)
    input "Tag"
    read -r t_tag
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
# shellcheck disable=SC2317
git_commit() {
  input "Commit message"
  read -r c_message

  if [ -z "$c_message" ]; then
    error "Please provide commit message"
    return 1
  fi

  git add . && git commit -m "$c_message"
}

# Git Merge
git_merge() {
  git merge --edit -m "🔀 merge: branch $(git symbolic-ref --short HEAD) <-- from: $1" "$1"
}

# Git Merge
git_merge_no_ff() {
  git merge --no-ff --edit -m "🔀 merge: branch $(git symbolic-ref --short HEAD) <-- from: $1" "$1"
}

## feat – a new feature is introduced with the changes
git_new() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    git add . && git commit -m "🎉 feat: Inital commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    git_add_files_commit "$r_files" "🎉 feat: Inital commit"
  fi
}

## Feature
## feat – a new feature is introduced with the changes
git_feat() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "Feature commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "✨ feat: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "Feature commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "✨ feat: $r_commit"
  fi
}

## Performance Improvements.
## perf – performance improvements
git_performance() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "Improvements commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🚀 perf: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "Improvements commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "🚀 perf: $r_commit"
  fi
}

## Chore
## chore – changes that do not relate to a fix or feature and don't modify src or test files (for example updating dependencies)
git_chore() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "Chore commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "♻️ chore: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "Chore commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "♻️ chore: $r_commit"
  fi
}

## Fix
## fix – a bug fix has occurred
git_fix() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "Bug fix commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🐛 fix: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "Bug fix commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "🐛 fix: $r_commit"
  fi
}

#### RELEASE.
git_release() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "Release commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🔖 chore (release): $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "Release commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "🔖 chore (release): $r_commit"
  fi
}

## CI
## ci – changes to our CI configuration files and scripts
git_ci() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "CI commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "⚙️ ci: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "CI commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "⚙️ ci: $r_commit"
  fi
}

## Documentation
## docs – updates to documentation such as a the README or other markdown files
git_doc() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "Documentation commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "📚 doc: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "Documentation commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "📚 doc: $r_commit"
  fi
}

## Testing
## test – changes to our test suite
git_test() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "Test commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🚨 test: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "Test commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "🚨 test: $r_commit"
  fi
}

## Refactor.
## refactor – refactored code that neither fixes a bug nor adds a feature
git_refactor() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "Refactor commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "📦 REFACTOR: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "Refactor commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "📦 REFACTOR: $r_commit"
  fi
}

## Style
## style – changes that do not affect the meaning of the code, likely related to code formatting such as white-space, missing semi-colons, and so on.
git_style() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "Style commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "💎 style: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "Style commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "💎 style: $r_commit"
  fi
}

## Build
## build – changes that affect the build system or external dependencies
git_build() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "Build commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🛠 build: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "Build commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "🛠 build: $r_commit"
  fi
}

## Revert
## revert – revert a previously committed change
git_revert() {
  if [[ -n "$1" && "$1" == "--push" ]]; then
    input "Repository name (default: origin)"
    read -r r_name
    input "Revert commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git add . && git commit -m "🔙 revert: $r_commit" && git push "${r_name:-origin}" "$(git symbolic-ref --short HEAD)"
  else
    input "Add files"
    read -r r_files
    input "Revert commit message"
    read -r r_commit
    if [ -z "$r_commit" ]; then
      error "Please provide git commit message"
      return 1
    fi
    git_add_files_commit "$r_files" "🔙 revert: $r_commit"
  fi
}
