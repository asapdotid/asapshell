# ASAPSHELL :computer:

Shell script utility aliases for (bash or zsh)

## General Aliases

- [x] Custom
- [x] System (will update)
- [x] Exa [doc](https://the.exa.website/)
- [x] NVM [doc](https://github.com/nvm-sh/nvm)
- [x] SSH
- [x] Git
- [x] Git-Flow
- [x] Ansible
- [x] Node JS
- [x] Terraform
- [x] Vagrant
- [x] Tmux
- [x] Tmuxinator
- [x] Docker
- [x] Docker Compose
- [ ] Spotify Tui

Will always update 🚀 each part OS and services 😃

## How to integrate on BASH/ZSH

Clone this repo to config user:

```bash
git clone https://github.com/asapdotid/asapshell.git "${HOME}"/.config/asapshell
```

Add script to load `aliases` to ZSH or BASH config `(.zshrc or bashrc)` on the bottom.

```bash
[[ -s $HOME/.config/asapshell/aliases ]] source "$HOME/.config/asapshell/aliases"
```

or

```bash
if [[ -d "$HOME/.config/asapshell" ]] ; then
    source "$HOME/.config/asapshell/aliases"
fi
```

Refrence :

- [Emoji Log](https://github.com/ahmadawais/Emoji-Log)

## License

GNU GENERAL PUBLIC LICENSE

## Author Information

This Ansible IAC was created in 2021 by [Asapdotid](https://github.com/asapdotid).
