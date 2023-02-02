source ./utils.sh

DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

info '================================================'
info 'Installing Dependencies'
info '================================================'

echo ''
echo ''

# ZSH Setup
# ================================================
name="oh-my-zsh"
location="${HOME}/.oh-my-zsh"
(check_file "$name" "$location") || {
  install () { sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; }
  attempt "$name" install
}

name="zsh-autosuggestions"
location="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
(check_file "$name" "$location") || {
  install () { git clone git@github.com:zsh-users/zsh-autosuggestions.git "$location"; }
  attempt "$name" install
}

name="zsh-syntax-highlighting"
location="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
(check_file "$name" "$location") || {
  install () { git clone git@github.com:zsh-users/zsh-syntax-highlighting.git "$location"; }
  attempt "$name" install
}

name="fzf-tab"
location="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/fzf-tab"
(check_file "$name" "$location") || {
  install () { git clone git@github.com:Aloxaf/fzf-tab.git "$location"; }
  attempt "$name" install
}

# Package Manager Packages
# ================================================
if check_mac
then
  ## Homebrew Setup
  name="homebrew"
  command="brew"
  (check_program "$name" $command) || {
    install () { /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; }
    attempt "$name" install
  }

  packages=(
    "starship" # Terminal prompt
    "neovim" # nvim editor
    "ripgrep" # astronvim dependency
    "coreutils" # asdf dependency
    "gpg" # asdf node plugin dependency
    "gawk" # asdf node plugin dependency
  )

  install_packages () { brew install ${packages[@]}; }
  attempt "brew packages" install_packages

  # Check for font install as homebrew fails if already installed
  name="Fira Code Nerd Font"
  location="${HOME}/Library/Fonts/Fira Code SemiBold Nerd Font Complete.ttf"
  (check_file "$name" "$location") || {
    install () { brew install homebrew/cask-fonts/font-fira-code-nerd-font; }
    attempt "$name" install
  }
  #
  # Check for font install as homebrew fails if already installed
  name="Alacritty"
  command="alacritty"
  (check_program "$name" "$command") || {
    install () { brew install alacritty --no-quarantine; }
    attempt "$name" install
  }
elif check_apt
then
  packages=(
    "neovim" # nvim editor
    "python3-neovim" # nvim dependency
    "ripgrep" # astronvmin dependency
    "dirmngr" # asdf node plugin dependency
    "gpg" # asdf node plugin dependency
    "gawk" # asdf node plugin dependency
  )

  install_packages () { sudo apt-get install -y ${packages[@]}; }
  attempt "apt packages" install_packages
elif check_yum
then
  packages=(
    "https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm" # nvim dependency
    "neovim" # nvim editor
    "python3-neovim" # nvim dependency
    "ripgrep" # astronvmin dependency
    "dirmngr" # asdf node plugin dependency
    "gpg" # asdf node plugin dependency
    "gawk" # asdf node plugin dependency
  )

  install_packages () {
    sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    sudo yum install -y ${packages[@]}
  }
  attempt "yum packages" install_packages
else
  fail "Failed to find correct package manager"
fi

# asdf and node
# ================================================
name="asdf"
location="${HOME}/.asdf"
(check_file "$name" "$location") || {
  install () {
    git clone https://github.com/asdf-vm/asdf.git "$location"
    source "${HOME}/.oh-my-zsh/plugins/asdf/asdf.plugin.zsh" # source the asdf plugin to get asdf on PATH. oh-my-zsh handles this by default after reload
  }
  attempt "$name" install
}

name="node"
command="node"
(check_program "$name" $command) || {
  install() {
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs latest
    asdf global nodejs latest
  }
  attempt "$name" install
}

# tree-sitter-cli
# ================================================
name="tree-sitter-cli"
command="tree-sitter"
(check_program "$name" $command) || {
  install () { npm install -g tree-sitter-cli; }
  attempt "$name" install
}

# AstroNvim
# ================================================
name="AstroNvim"
location="${HOME}/.config/nvim"
(check_file "$name" "$location") || {
  install () { git clone git@github.com:AstroNvim/AstroNvim.git ~/.config/nvim; }
  attempt "$name" install
}

# starship
# ================================================
# name="starship"
# command="starship"
# (check_program "$name" $command) || {
#   install () { curl -sS https://starship.rs/install.sh | sh; }
#   attempt "$name" 
# }


echo ''
echo ''
success 'All installed!'
