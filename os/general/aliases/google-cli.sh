#!/bin/bash

# Gcloud
alias gc='gcloud'
alias gc:-h='gcloud help'
alias gc:-v='gcloud version'
alias gc:comp:i='gcloud components install'
alias gc:comp:u='gcloud components update'
alias gc:a='gcloud auth'
alias gc:c='gcloud config'
alias gc:i='gcloud iam'
alias gc:p='gcloud projects'
alias gc:con='gcloud container'
alias gc:com='gcloud compute'
alias gc:app='gcloud app'

# Functions
# Gsutil
alias gs='gsutil'
alias gs:l='gsutil ls'
alias gs:b='gsutil_bucket_utility'
alias gs:fd='gsutil_folder_file_utility'

gsutil_bucket_utility() {
  PS3='Bucket Utility to create (mb) or remove (rb) bucket: '
  select bucket_utility in "Create" "Remove" "Quit"; do
    case $bucket_utility in
    "Create")
      input "Create bucket name "
      read bucket_name
      if [ ! -z "$bucket_name" ]; then
        gsutil mb gs://${bucket_name}
      else
        error "Bucket name is empty!"
      fi
      break
      ;;
    "Remove")
      input "Remove bucket name "
      read bucket_name
      if [ ! -z "$bucket_name" ]; then
        gsutil rb gs://${bucket_name}
      else
        error "Bucket name is empty!"
      fi
      break
      ;;
    "Quit")
      break
      ;;
    *)
      error "Invalid option, select create or remove bucket!"
      break
      ;;
    esac
  done
}

gsutil_folder_file_utility() {
  PS3='Bucket directory of file utility on bucket: '
  select bucket_utility in "Copy" "Remove" "Move" "Quit"; do
    case $bucket_utility in
    "Copy")
      input "Bucket name "
      read bucket_name
      input "Copy file/directory source "
      read file_dir_source
      input "Bucket file/directory target "
      read file_dir_target
      if [[ ! -z "$bucket_name" && ! -z "$file_dir_source" && ! -z "$file_dir_target" ]]; then
        gsutil cp ${file_dir_source} gs://${bucket_name}/${file_dir_target}
      else
        error "Please enter bucket name, file/directory source and target on bucket!"
      fi
      break
      ;;
    "Remove")
      input "Bucket name "
      read bucket_name
      input "Remove file/directory name "
      read file_dir_name
      if [[ ! -z "$bucket_name" && ! -z "$file_dir_name" ]]; then
        gsutil rm gs://${bucket_name}/${file_dir_name}
      else
        error "Please enter both bucket name and file/directory name on bucket!"
      fi
      break
      ;;
    "Move")
      input "Bucket name "
      read bucket_name
      input "Move file/directory source "
      read file_dir_source
      input "Bucket file/directory target "
      read file_dir_target
      if [[ ! -z "$bucket_name" && ! -z "$file_dir_source" && ! -z "$file_dir_target" ]]; then
        gsutil mv ${file_dir_source} gs://${bucket_name}/${file_dir_target}
      else
        error "Please enter bucket name, file/directory source and target on bucket!"
      fi
      break
      ;;
    "Quit")
      break
      ;;
    *)
      error "Invalid option, select create or remove bucket!"
      break
      ;;
    esac
  done
}
