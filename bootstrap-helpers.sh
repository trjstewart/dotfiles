#!/bin/bash

function get_system_os() {
  echo $(uname -s)
}

function is_mac() {
  if [[ "$(get_system_os)" == "Darwin" ]]; then
    return 0
  else
    return 1
  fi
}

function is_linux() {
  if [[ "$(get_system_os)" == "Linux" ]]; then
    return 0
  else
    return 1
  fi
}

color() { echo -n "\033[$1m"; }
color_black() { color '0;30'; }
color_red() { color '0;31'; }
color_green() { color '0;32'; }
color_brown() { color '0;33'; }
color_blue() { color '0;34'; }
color_purple() { color '0;35'; }
color_cyan() { color '0;36'; }
color_light_gray() { color '0;37'; }
color_dark_gray() { color '1;30'; }
color_light_red() { color '1;31'; }
color_light_green() { color '1;32'; }
color_yellow() { color '1;33'; }
color_light_blue() { color '1;34'; }
color_light_purple() { color '1;35'; }
color_light_cyan() { color '1;36'; }
color_white() { color '1;37'; }
color_reset() { color '0'; }

print_success() { echo -e "$(color_green)$@$(color_reset)"; }
print_failure() { echo -e "$(color_red)$@$(color_reset)"; }
print_message() { echo -e "$(color_cyan)$@$(color_reset)"; }
print_info() { echo -e "$(color_purple)$@$(color_reset)"; }
print_warning() { echo -e "$(color_yellow)$@$(color_reset)"; }

silent() {
  $@ > /dev/null
}

really_silent() {
  $@ > /dev/null  2>&1
}

verify_location() {
  if [[ ! "${PWD##*/}" == ".dotfiles" ]]; then
    print_failure "You must be in the .dotfiles folder!"
    exit 1
  fi

  if [[ ! $(dirname $PWD) == $HOME ]]; then
    print_failure "The .dotfiles folder must be located inside your home directory!"
    exit 1
  fi
}

request_sudo_access() {
  if ! sudo -v; then
    print_failure "sudo is required to continue"
    exit 1
  fi
}

install_homebrew() {
  print_message " ➤ Installing Homebrew..."
  silent /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
}

install_homebrew_packages() {
  print_message " ➤ Installing Homebrew packages from Brewfile..."
  silent brew bundle install
}

install_oh_my_zsh() {
  print_message " ➤ Installing Oh My Zsh..."
  if [[ -e ~/.oh-my-zsh ]]; then
    print_message " ➤ Oh My Zsh is already installed!"
  else
    silent sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
}

# switch_default_shell_to_zsh() {
#   print_info " ➤ Switching default shell to zsh..."
#   really_silent sudo chsh -s $(which zsh) $USER
# }

switch_default_shell_to_zsh() {
  print_info " ➤ Switching default shell to zsh..."
  ZSH_SHELL_PATH="$(brew --prefix)/bin/zsh"

  if cat /etc/shells | silent grep "$ZSH_SHELL_PATH"; then
    print_message " ➤ ZSH is already in /etc/shells"
  else
    # put it there
    echo "$ZSH_SHELL_PATH" | sudo tee -a /etc/shells > /dev/null
    print_message " ➤ Added $ZSH_SHELL_PATH to /etc/shells"
  fi

  sudo chsh -s /usr/local/bin/zsh $USER > /dev/null 2>&1 
}

unpack_from_stow() {
  print_message " ➤ Unpacking dotfiles from stow..."
  
  STOW_POINTS=$(echo */)
  for point in $STOW_POINTS; do
    print_info " ➤ Linking ${point/\//}..."
    stow $point
  done
}

source_zshrc() {
  source $HOME/.zshrc
}

[[ "${BASH_SOURCE[0]}" != "${0}" ]] && echo -e "$(color_purple)>>> ${BASH_SOURCE[0]#"./"} has been sourced...$(color_reset)\n"
