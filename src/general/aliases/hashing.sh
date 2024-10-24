#!/bin/bash

# Hashing
generate_hash() {
  input "Password Hashing Script"
  echo -e "\n1. MD5"
  echo "2. SHA-256"
  echo "3. SHA-512"
  input "Choose a hash method (1|2|3)"
  read -r r_method

  if [ "$r_method" == "1" ]; then
    hash_method="md5"
  elif [ "$r_method" == "2" ]; then
    hash_method="sha-256"
  elif [ "$r_method" == "3" ]; then
    hash_method="sha-512"
  else
    echo "Invalid choice."
    return
  fi

  read -r -p "Enter the salt (leave blank for default): " salt
  read -r -p "Enter the number of rounds (leave blank for default): " rounds
  read -r -p "Enter the password you want to hash: " password

  command="mkpasswd -m $hash_method"
  if [ ! -z "$salt" ]; then
    command="$command -S $salt"
  fi
  if [ ! -z "$rounds" ]; then
    command="$command -R $rounds"
  fi

  hash=$(echo "$password" | $command -s)
  echo "---------------------------------------------------------"
  echo " Generated hash: $hash"
  echo "---------------------------------------------------------"
}

# Main
call_generate_hash() {
  while true; do
    generate_hash

    read -r -p "Do you want to generate another hash? (y/n): " choice
    if [ "$choice" != "y" ]; then
      echo "Good Bye!"
      break
    fi
  done
}

# Aliases
alias gen:hash='call_generate_hash'
