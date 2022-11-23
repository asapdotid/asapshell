#!/bin/bash

function helper_array() {
  local array_files=$1
  local add_files
  [[ ${array_files[@]:+${array_files[@]}} ]] &&
    add_files="${array_files[@]}" || add_files="."
  echo $add_files
}
