info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

file_exists () {
  test -f "$1" || test -d "$1" || test -L "$1"
}

program_exists () {
  if command -v "$1" &> /dev/null
  then
    true
  else
    false
  fi
}

install_prompt () {
  info "Installing ${1}..."
}

install_success () {
  success "Installed ${1}"
}

install_fail () {
  fail "Failed to install ${1}"
}

install_skip () {
  success "Skipping ${1} - already installed"
}

attempt () {
  local name=$1
  local install=$2
  install_prompt "$name"
  ($install) || {
    install_fail "$name"
  }
  install_success "$name"
}

check_file () {
  local name=$1
  local location=$2
  if (file_exists "$location")
  then
    install_skip "$name"
    true
  else
    false
  fi
}

check_program () {
  local name=$1
  local command=$2
  if (program_exists $command)
  then
    install_skip "$name"
    true
  else
    false 
  fi
}

check_mac () {
  [ $(uname) = Darwin ]
}

check_apt () {
  program_exists "apt-get"
}

check_yum () {
  program_exists "yum"
}

unknown_host () {
  fail "Failed to install $name - Unknown Host"
}
