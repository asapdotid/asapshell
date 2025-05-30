#!/bin/bash

# Aliases
alias c='clear'
alias .1='change_dir 1'
alias .2='change_dir 2'
alias .3='change_dir 3'
alias .4='change_dir 4'
alias .5='change_dir 5'
alias df="df -h"
alias du="du -sh"
alias free='free -m'           # show sizes in MB
alias grep='grep --color=auto' # colorize output (good for log files)
alias rm:f='rm -rf'
alias s:rm:f='sudo rm -rf'
alias cp:r='cp -rv'
alias s:cp:r='sudo cp -rv'
alias cp:sync='rsync -azP'
alias f:f="find_file"
alias f:x="find_ext"
alias history='history | grep'
alias mkcd='mk_cd'

# ps
alias ps:a="ps auxf"
alias ps:grep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias ps:mem='ps auxf | sort -nr -k 4'
alias ps:cpu='ps auxf | sort -nr -k 3'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Functions
# Change directory
cd_home_dot() {
  if [[ -n "$1" && -d "$HOME/.$1" ]]; then
    cd "$HOME/.$1" || return
  else
    error "Please check your directory destination first!"
  fi
}

# Make directory and change directory
mk_cd() {
  if [[ -n "$1" ]]; then
    mkdir -p -- "$1" && cd -P -- "$1" || return
  else
    error "Please check your directory destination first!"
  fi
}

# Search for a specific file (plocate)
find_file() {
  local dir=$1
  local file=$2
  local opt=${3:-""}
  if [[ -n "$dir" && -n "$file" ]]; then
    plocate -w "$dir" "$file" "$opt"
  else
    error "Please check your directory and file destination first!"
  fi
}

# Search for all files with a specific extension (plocate)
find_ext() {
  local dir=$1
  local ext=$2
  local opt=${3:-""}
  if [[ -n "$dir" && -n "$ext" ]]; then
    plocate -w "$dir" --regex ".*\.${ext}" "$opt"
  else
    error "Please check your directory and file extension!"
  fi
}

change_dir() {
  local cd_dir=""
  if [[ -n $1 ]] && [[ "$1" =~ ^[0-9]+$ ]]; then
    for ((i = 1; i <= $1; i++)); do
      cd_dir+="../"
    done
    cd $cd_dir || return
  else
    error "Whoops!, please check destination"
  fi
}

### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

### ARCHIVE EXTRACTION
# usage: ex <file>
function ex {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
  else
    for n in "$@"; do
      if [ -f "$n" ]; then
        case "${n%,}" in
        *.cbt | *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar)
          tar xvf "$n"
          ;;
        *.lzma) unlzma ./"$n" ;;
        *.bz2) bunzip2 ./"$n" ;;
        *.cbr | *.rar) unrar x -ad ./"$n" ;;
        *.gz) gunzip ./"$n" ;;
        *.cbz | *.epub | *.zip) unzip ./"$n" ;;
        *.z) uncompress ./"$n" ;;
        *.7z | *.arj | *.cab | *.cb7 | *.chm | *.deb | *.dmg | *.iso | *.lzh | *.msi | *.pkg | *.rpm | *.udf | *.wim | *.xar)
          7z x ./"$n"
          ;;
        *.xz) unxz ./"$n" ;;
        *.exe) cabextract ./"$n" ;;
        *.cpio) cpio -id <./"$n" ;;
        *.cba | *.ace) unace x ./"$n" ;;
        *)
          echo "ex: '$n' - unknown archive method"
          return 1
          ;;
        esac
      else
        echo "'$n' - file does not exist"
        return 1
      fi
    done
  fi
}

IFS=$SAVEIFS

# navigation
up() {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i = 1; i <= limit; i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs."
  fi
}
