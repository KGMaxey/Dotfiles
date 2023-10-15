# Dotfiles

This is a standard dotfiles repo using [GNU Stow](https://www.gnu.org/software/stow/).

## Install

This repo uses the typical stow defaults with `${HOME}/` expected to be the target directory and thus `${HOME}/dotfiles` to be this repo's path

- Install Stow
    - `brew install stow`
    - `apt install stow`
    - etc..
- Checkout this repo to user home directory
- Run `stow ${PACKAGE_NAME}` for all packages in repo

## Font

I typically run on Mac devices and enjoy the consistency of the system font. So I use the [Meslo Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo) that is a patched version of the Meslo font that is based on Apple's default Menlo font.

Install latest patch release [here](https://github.com/ryanoasis/nerd-fonts/releases). Find the most recent release, download the `Meslo.zip` file, extract, and install all fonts.

## Alacritty Theme

My alacritty config depends on the themes published by alacritty [here](https://github.com/alacritty/alacritty-theme) for the gruvbox dark theme. Follow it's simple README to install the themes.
