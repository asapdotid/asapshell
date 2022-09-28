# ASAPSHELL :computer:

Shell script utility aliases for (bash or zsh)

## General Aliases

- [x] Ansible
- [x] Custom
- [x] Docker
- [x] Docker Compose
- [x] Exa [doc](https://the.exa.website/)
- [x] Git
- [x] Git-Flow
- [x] Node JS
- [x] NVM [doc](https://github.com/nvm-sh/nvm)
- [x] Path
- [x] SSH
- [x] System (will update)
- [x] Terraform
- [x] Tmux
- [x] Tmuxinator
- [x] Vagrant
- [x] Spotify Tui
- [ ] Molecule
- [ ] Youtube Download (yt-download)

## Linux Aliases

- [x] Package
- [x] Service
- [x] System

## Darwin Aliases

- [ ] Package
- [ ] Service
- [ ] System

Will always update 🚀 each part OS and services 😃

## How to setup on BASH/ZSH

### Install & Update Script

To install or update asapshell, you should run the install script. To do that, you may either download and run the script manually, or use the following cURL or Wget command:

```bash
curl -o- https://raw.githubusercontent.com/asapdotid/asapshell/main/install.sh | bash
```

or

```bash
wget -qO- https://raw.githubusercontent.com/asapdotid/asapshell/main/install.sh | bash
```

Edit environment file `.env`:

According to the application you are using:

```bash
...

# Editor (Custom with editor do you have)
EDITOR='nvim'
VSCODE='vscodium' # or vscode/code

# Custom with path do you have
LAB_LOCATION="$HOME/Labs"
PROJECT_LOCATION="$HOME/Projects"
```

Running either of the above commands downloads a script and runs it. The script clones the asapshell repository to ~/.asapshell, and attempts to add the source lines from the snippet below to the correct profile file (~/.bash_profile, ~/.zshrc, ~/.profile, or ~/.bashrc).

```bash
export ASAPSHELL_DIR="$HOME/.asapshell"
[ -s "$ASAPSHELL_DIR/aliases" ] && \. "$ASAPSHELL_DIR/aliases" # This loads asapshell
```

Additional Notes

If the environment variable $XDG_CONFIG_HOME is present, it will place the asapshell files there.

You can customize the install source, directory, profile, and version using the ASAPSHELL_SOURCE, ASAPSHELL_DIR, PROFILE, and NODE_VERSION variables. Eg: curl ... | ASAPSHELL_DIR="path/to/asapshell". Ensure that the ASAPSHELL_DIR does not contain a trailing slash.

The installer can use git, curl, or wget to download asapshell, whichever is available.

Troubleshooting on Linux

On Linux, after running the install script, if you get asapshell: command not found or see no feedback from your terminal after you type command -v asapshell, simply close your current terminal, open a new terminal, and try verifying again. Alternatively, you can run the following commands for the different shells on the command line:

_bash: source ~/.bashrc_

_zsh: source ~/.zshrc_

_ksh: . ~/.profile_

Refrence :

- [Emoji Log](https://github.com/ahmadawais/Emoji-Log)

## License

GNU GENERAL PUBLIC LICENSE

## Author Information

This code was created in 2022 by [Asapdotid](https://github.com/asapdotid).
