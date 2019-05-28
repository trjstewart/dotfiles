#!/bin/bash

# enable debug logging if necessary
DEBUG=false
[ "$DEBUG" == 'true' ] && set -x

# import some helper functions to make our life a little easier
if [[ -e ./bootstrap-helpers.sh ]]; then
. ./bootstrap-helpers.sh
fi

print_message "Welcome to bootstrapper $USER! Let's get started setting up your system... 🤔"
verify_location
request_sudo_access

if [[ is_mac ]]; then
  print_info "It looks like you're trying to setup a mac, let's get brewing!"
  install_homebrew
  # install_homebrew_packages
  install_oh_my_zsh
  unpack_from_stow
  switch_default_shell_to_zsh
  # source_zshrc
fi

if [[ is_linux == "true" ]]; then
  print_info "It looks like you're trying to setup linux, let's assume it's Ubuntu and apt-get going!"
  
fi

print_success " ➤ Bootstrap Complete! 🎉"

# disable debug logging if set
[ "$DEBUG" == 'true' ] && set +x
