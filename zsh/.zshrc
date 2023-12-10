source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}

source_if_exists $HOME/.env.sh

export EDITOR='nvim'

export PATH=$HOME/Library/Python/3.8/bin:$PATH
export PATH=$HOME/Library/Python/3.11/bin:$PATH

export PATH=$HOME/.local/bin:$PATH

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

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
