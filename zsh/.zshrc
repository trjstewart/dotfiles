# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
autoload -Uz compinit
compinit
# End of lines added by compinstall

# zsh auto-suggestion
zstyle ':completion:*' menu select

# terminal theme
autoload -U promptinit && promptinit
prompt filthy

# load node-version-manager (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

source ~/.env
source ~/.config/zsh/env.zsh
source ~/.config/zsh/plugins.zsh
source ~/.config/zsh/alias.zsh
source ~/.config/zsh/functions.zsh
