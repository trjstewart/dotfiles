#!/bin/bash

# request sudo access to perform bootstrap
if ! sudo -v; then
  echo "ERROR: sudo is required to continue!"
  exit 1
fi

# install system updates
apt-get update -y
apt-get upgrade -y
apt-get dist-upgrade -y

# install required packages
apt-get install -y git curl build-essential libssl-dev zsh zplug

# install node-version-manager (nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | NODE_VERSION=lts/* bash
chown -R $USER:$(id -gn $USER) $HOME/.config

# set default shell to zsh
chsh -s /bin/zsh

# generate ssh key
if [[ -f "~/.ssh/id_rsa" ]]; then
  mkdir ~/.ssh
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -P "" -C trjstewart@gmail.com
fi

# for now we'll be lazy and just manually copy each of the required files or folders for dotfile config
cp -v "$PWD/git/.gitconfig" "$HOME"
cp -vr "$PWD/zsh/.config" "$HOME"
cp -v "$PWD/zsh/.zshrc" "$HOME"

# TODO: source files here?

