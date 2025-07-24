![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/dariogriffo/zls-debian/total)
![GitHub Downloads (all assets, latest release)](https://img.shields.io/github/downloads/dariogriffo/zls-debian/latest/total)
![GitHub Release](https://img.shields.io/github/v/release/dariogriffo/zls-debian)
![GitHub Release Date](https://img.shields.io/github/release-date/dariogriffo/zls-debian)

<h1>
   <p align="center">
     <a href="https://github.com/zigtools/zls/"><img src="https://github.com/dariogriffo/zls-debian/blob/main/zls-logo.png" alt="Zls Logo" width="128" style="margin-right: 20px"></a>
     <a href="https://www.debian.org/"><img src="https://github.com/dariogriffo/zls-debian/blob/main/debian-logo.png" alt="Debian Logo" width="104" style="margin-left: 20px"></a>
     <br>Zig for Debian
   </p>
</h1>
<p align="center">
 ZLS is a non-official implementation of the Language Server Protocol for Zig in Zig. It provides developers with IDE features in their editor.
</p>

# Zls master for Debian

This repository contains build scripts to produce the _unofficial_ Debian packages
(.deb) for [Zls](https://github.com/zigtools/zls) (nightly builds) hosted at [debian.griffo.io](https://debian.griffo.io)

Currently supported debian distros are:
- Bookworm
- Trixie
- Sid

This is an unofficial community project to provide a package that's easy to
install on Debian. If you're looking for the Zls source code, see
[zigtools/zls](https://github.com/zigtools/zls).

## Install/Update

### The Debian way

```sh
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
sudo apt install zls
```

### Manual Installation

1. Download the .deb package for your Debian version available on
   the [Releases](https://github.com/dariogriffo/zls-debian/releases) page.
2. Install the downloaded .deb package.

```sh
sudo dpkg -i <filename>.deb
```
## Updating

To update to a new version, just follow any of the installation methods above. There's no need to uninstall the old version; it will be updated correctly.

## Contributing

I want to have an easy-to-install Zls package for Debian, so I'm doing what
I can to make it happen.
If you want to test locally, you should be able to run
[build_zls_debian.sh](https://github.com/dariogriffo/zls-debian/blob/main/build_zls_debian.sh)
on your own Debian system, only requirement is docker.

## Roadmap

- [x] Produce a .deb package on GitHub Releases
- [x] Set up a debian mirror for easier updates

## Disclaimer

- This repo is not open for issues related to zls. This repo is only for _unofficial_ Debian packaging.
- This repository is based on the amazing work of [Mike Kasberg](https://github.com/mkasberg) and his [Zig Ubuntu](https://github.com/mkasberg/ghostty-ubuntu) packages
