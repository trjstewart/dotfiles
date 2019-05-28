export ZSH="/Users/tylor/.oh-my-zsh"

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

# zsh theme
ZSH_THEME=robbyrussell

plugins=(
  aws
  docker
  docker-compose
  npm
  nvm
  themes
)

source $ZSH/oh-my-zsh.sh
# source ~/.env
source ~/.config/zsh/env.zsh
# source ~/.config/zsh/plugins.zsh
source ~/.config/zsh/alias.zsh
source ~/.config/zsh/functions.zsh
