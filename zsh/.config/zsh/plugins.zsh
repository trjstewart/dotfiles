export ZPLUG_HOME=/usr/share/zplug
source $ZPLUG_HOME/init.zsh

function load_plugins() {
  zplug 'zsh-users/zsh-syntax-highlighting'
  zplug "zdharma/zsh-diff-so-fancy", as:command, use:bin/git-dsf
}

load_plugins

if ! zplug check; then
  zplug install
fi

zplug load
