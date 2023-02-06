source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}

source_if_exists $HOME/.env.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export PATH=$HOME/Library/Python/3.8/bin:$PATH

# Custom sourcing
precmd() {
    source $DOTFILES/zsh/aliases.zsh
}
source $DOTFILES/zsh/omz-config.zsh
source $DOTFILES/zsh/nvim-config.zsh

# Reset terminal colors after oh-my-zsh attempts to set 
unset LSCOLORS

# Init Starship Prompt - See .config/starship.toml
eval "$(starship init zsh)"
