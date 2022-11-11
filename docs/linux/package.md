# Aliases for Linux

🏠 [Back to Home](../../README.md)

## Package

- Debian Family (apt-get)
- ArchLinux Family (pacman)
- Gento Family (emerge)
- RedHat Family (yum)
- OpenSUSE Family (zypper)

| Aliases   | Paramenters | Description                    |
| --------- | ----------- | ------------------------------ |
| pkg:i     | Package     | Package install `pkg:i git`    |
| pkg:ui    | Package     | Package uninstall `pkg:ui git` |
| pkg:s     | Package     | Package search `pkg:s git`     |
| pkg:u     | Package     | Update all packages `pkg:u`    |
| pkg:clean | Package     | Cleaning packages              |

## Special for Archlinux (pacman)

### Refresh mirror repository

```bash
pacman:mirror Indonesia https
```

| Aliases       | Paramenters              | Description                                                                       |
| ------------- | ------------------------ | --------------------------------------------------------------------------------- |
| pacman:mirror | - Country default `all`  | Reset mirror repository `stable` packages with Country region (Indonesia)         |
|               | - Protocol default `all` | Reset mirror repository `stable` packages with Protocol (ftp, http, https or all) |

### YAY - AUR

| Aliases   | Paramenters | Description                             |
| --------- | ----------- | --------------------------------------- |
| yay:i     | Package     | Package install `yay:i apache-tools`    |
| yay:ui    | Package     | Package uninstall `yay:ui apache-tools` |
| yay:s     | Package     | Package search `yay:s apache-tools`     |
| yay:u     | Package     | Update all packages `yay:u`             |
| yay:clean | Package     | Cleaning packages                       |
