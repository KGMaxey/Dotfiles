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
    source $HOME/.zsh/aliases.zsh
}
source $HOME/.zsh/omz-config.zsh
source $HOME/.zsh/nvim-config.zsh

# Reset terminal colors after oh-my-zsh attempts to set 
unset LSCOLORS

complete -C '/opt/homebrew/bin/aws_completer' aws
complete -C '/opt/homebrew/bin/aws_completer' awslocal

alias python=/opt/homebrew/bin/python3

# Init Starship Prompt - See .config/starship.toml
eval "$(starship init zsh)"
