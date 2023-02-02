# Dotfiles

Much of the inspiration and code for this dotfiles configuration and installation
is inspired by or copied from [Andrew Burgess'](https://github.com/andrew8088)
and his [Dotfiles repo](https://github.com/andrew8088/dotfiles). Go check out
his page. He has great articles on his own website and videos on his youtube
channel where he shares much of his work.

This repo has both an instalation script for bootstrapping my default terminal
environment as well generating symlinks for all dotfiles.

## Install

Simply clone this repo where ever you prefer to keep your projects and run the
`install.sh` script to bootstrap the environement, then run the
`link_files.sh` script to generate all of the correct symlinks to the dotfiles.

The scripts will correctly locate the project directory and setup the path
variables so you can place this project wherever you like. They will
also skip any already installed packages as well as provide options to
override, backup, or skip any existing configured dotfiles. 

## Local ZSH Config

If there's customization you want ZSH to load on startup that is specific to 
this machine (stuff you don't want to commit into the repo), use the `~/.env.sh`
file created by the `link_files.sh` script and put it in there.
It will be loaded near the top of `.zshrc`.
