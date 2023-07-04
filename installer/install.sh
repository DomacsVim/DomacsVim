#!/usr/bin/bash

OS=$(uname -s)

DVIM_BRANCH="${DVIM_BRANCH:-main}"
DVIM_GIT_REPOSITORY="${DVIM_GIT_REPOSITORY:-https://gitlab.com/domacsvim/domacsvim.git}"
DVIM_RUNTIME_DIR="${DVIM_RUNTIME_DIR:-$HOME/.local/share/domacsvim}"
DVIM_CONFIG_DIR="${DVIM_CONFIG_DIR:-$HOME/.config/dvim}"
DVIM_CACHE_DIR="${DVIM_CACHE_DIR:-$HOME/.cache/dvim}"

welcome_message(){
  printf "\n\33[1m Welcome to Domacsvim!\33[0m\n"
cat 1>&2 <<EOF

   An IDE layer for Neovim with beautiful, flexible, extensible, completely free
  and open source lua-based configurations for Unix-based systems.

   The path where user customization files are placed is "$HOME/.config/dvim" which is created by default at runtime.
  You can open "init.lua" file and enter your desired customizations in it.
  By entering the command nvim, NeoVim will open for you. But to access DomacsVim enter dvim command.
EOF
  printf "\n\33[1m Pre-requisites\33[0m\n"
cat 1>&2 <<EOF

   Before you start the installation process, make sure that these packages are installed on your system: ["git", "make", "pip", "python", "npm", "node"]

   Nerd Font as your terminal font: "https://www.nerdfonts.com/"

   Ripgrep is required for grep searching with Telescope (OPTIONAL): "https://github.com/BurntSushi/ripgrep"
EOF
  printf "\n\33[1m Installation\33[0m\n"
cat 1>&2 <<EOF

   When you are sure that the prerequisites are installed, getting start the installation process.

   You can start the installation process by writing a command line. You will be asked several questions to install the desired packages.
  and if needed (the package in question is not pre-installed on your system) you answer with ( y ) and
  otherwise (if the package in question is pre-installed on your system) with ( n ) you answer and that's it.

EOF
}

usage() {
cat 1>&2 <<EOF

USAGE: install.sh [FLAGS]
FLAGS:
  -i  , --install                        Installing domacsvim and all Dependencies.
  -ib , --install-bin                    Installing domacsvim bin file.
  -h  , --help                           Show this message.
  -nd , --no-install-dependencies        Installing domacsvim with minimal Setup.
  -id , --install-dependencies           Installing domacsvim dependencies.

EOF
}

confirm(){
  question="$1"
  while true; do
    echo ""
    echo "   $question"
    read -p "  [y]es or [n]o (default: yes) : " -r answer
    case "$answer" in
      y | Y | yes | YES | Yes | "")
        return 0
        ;;
      n | N | no | NO | No)
        return 1
        ;;
      *)
        echo "Please answer [y]es or [n]o."
        ;;
    esac
  done
}

check_neovim_min_version(){
  local verify_version_cmd='if !has("nvim-0.9") | cquit | else | quit | endif'

  # exit with an error if min_version not found
  if ! nvim --headless -u NONE -c "$verify_version_cmd"; then
    printf "\33[1m Failed to installation \n\n"
    printf "  [ERROR]: Domacsvim requires at least Neovim v0.9 : \"https://github.com/neovim/neovim/releases\"\33[1m"
    echo ""
    exit 1
  fi
}

backup() {
  printf "\33[1m Getting backup\n\n\33[0m"
  printf "Remove $DVIM_RUNTIME_DIR.old backup \n"
  if [ -d "$DVIM_RUNTIME_DIR.old" ]; then
    rm -rf "$DVIM_RUNTIME_DIR.old"
  fi
  printf "Remove $DVIM_CONFIG_DIR.old backup \n"
  if [ -d "$DVIM_CONFIG_DIR.old" ]; then
    rm -rf "$DVIM_CONFIG_DIR.old"
  fi
  printf "Remove $DVIM_CACHE_DIR.old backup \n"
  if [ -d "$DVIM_CACHE_DIR.old" ]; then
    rm -rf "$DVIM_CACHE_DIR.old"
  fi

  printf "Backing up old $DVIM_RUNTIME_DIR to $DVIM_RUNTIME_DIR.old \n"
  if [ -d "$DVIM_RUNTIME_DIR" ]; then
    mv $DVIM_RUNTIME_DIR "$DVIM_RUNTIME_DIR.old"
  fi
  printf "Backing up old $DVIM_CONFIG_DIR to $DVIM_CONFIG_DIR.old \n"
  if [ -d "$DVIM_CONFIG_DIR" ]; then
    mv $DVIM_CONFIG_DIR "$DVIM_CONFIG_DIR.old"
  fi
  printf "Backing up old $DVIM_CACHE_DIR to $DVIM_CACHE_DIR.old \n\n"
  if [ -d "$DVIM_CACHE_DIR" ]; then
    mv $DVIM_CACHE_DIR "$DVIM_CACHE_DIR.old"
  fi
}

clone_dvim(){
  printf "\n\33[1m Cloning domacsvim\33[0m\n\n"
  if [[ ! -d $DVIM_RUNTIME_DIR ]]; then
    if ! git clone --progress --depth 1 --branch "$DVIM_BRANCH" \
      "$DVIM_GIT_REPOSITORY" "$DVIM_RUNTIME_DIR"; then
      echo "  󰅙 Failed to clone repository. Installation failed."
    fi
  else
    printf "   All configuration files are there.\n\n"
  fi
}

install_bin(){
  if [[ ! -d $HOME/.local/bin/ ]]; then
    mkdir $HOME/.local/bin
  fi
  if [[ ! -f $HOME/.local/bin/dvim ]]; then
    curl -s https://gitlab.com/domacsvim/domacsvim/-/raw/main/bin/domacsvim-cli-template.sh >> $HOME/.local/bin/dvim
    chmod +x $HOME/.local/bin/dvim
  fi
}

footer_message(){
  echo "Thank you for installing domacsvim :)"
  echo "You can start it by running: \"$HOME/.local/bin/dvim\" or \"dvim\""
  echo ""
}

install(){
  install_dependencies
  install_bin
  clone_dvim
  footer_message
}

no_install_dependencies(){
  install_bin
  clone_dvim
  footer_message
}

install_dependencies(){
  printf "\33[1m Install dependencies\33[0m\n\n"
  case "$OS" in
    Linux)
      if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
        printf "   Detecting platform: installing setup on arch based system.\n"
        if confirm "Would you like to install neovim ?"; then
          sudo pacman -S --noconfirm neovim
        fi
        if confirm "Would you like to install lua and luajit ?"; then
          sudo pacman -S --noconfirm luajit
          sudo pacman -S --noconfirm lua
        fi
        if confirm "Would you like to install neovim's python librarys ?"; then
          python3 -m pip install pynvim
        fi
        if confirm "Would you like to install node ?"; then
          sudo pacman -S --noconfirm nodejs npm yarn
        fi
        if confirm "Would you like to install treesitter and lazygit ?"; then
          sudo pacman -S --noconfirm lazygit tree-sitter
        fi
        if confirm "Would you like to install ripgrep ?"; then
          sudo pacman -S --noconfirm ripgrep
        fi
      elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
        printf "  󱄛 Detecting platform: installing setup on redhat based system.\n"
        if confirm "Would you like to install neovim ?"; then
          sudo dnf -y install neovim
        fi
        if confirm "Would you like to install lua and luajit ?"; then
          sudo dnf -y install luajit
          sudo dnf -y install lua
        fi
        if confirm "Would you like to install neovim's python librarys ?"; then
          python3 -m pip install pynvim
        fi
        if confirm "Would you like to install node ?"; then
          sudo dnf -y install nodejs npm yarn
        fi
        if confirm "Would you like to install ripgrep ?"; then
          sudo dnf -y install ripgrep
        fi
      elif [ -f "/etc/SuSE-release" ]; then
        printf "  󰣨 Detecting platform: installing setup on gento system.\n"
        if confirm "Would you like to install neovim ?"; then
          sudo zypper install neovim
        fi
        if confirm "Would you like to install lua and luajit ?"; then
          sudo zypper install luajit
          sudo zypper install lua
        fi
        if confirm "Would you like to install neovim's python librarys ?"; then
          python3 -m pip install pynvim
        fi
        if confirm "Would you like to install node ?"; then
          sudo zypper install nodejs npm yarn
        fi
        if confirm "Would you like to install ripgrep ?"; then
          sudo zypper install ripgrep
        fi
      else # assume debian based
        printf "   Detecting platform: installing setup on debian based system.\n"
        if confirm "Would you like to install neovim ?"; then
          sudo apt -y install neovim
        fi
        if confirm "Would you like to install lua and luajit ?"; then
          sudo apt -y install luajit
          sudo apt -y install lua5.4
        fi
        if confirm "Would you like to install neovim's python librarys ?"; then
          python3 -m pip install pynvim
        fi
        if confirm "Would you like to install node ?"; then
          sudo apt -y install nodejs npm yarn
        fi
      fi
      ;;
    FreeBSD)
      printf "   Detecting platform: installing setup on FreeBSD system.\n"
      if confirm "Would you like to install neovim ?"; then
        sudo pkg install neovim
      fi
      if confirm "Would you like to install lua and luajit ?"; then
        sudo pkg install luajit
        sudo pkg install lua
      fi
      if confirm "Would you like to install neovim's python librarys ?"; then
        python3 -m pip install pynvim
      fi
      if confirm "Would you like to install node ?"; then
        sudo pkg install nodejs npm yarn
      fi
      if confirm "Would you like to install ripgrep ?"; then
        sudo pkg install ripgrep
      fi
      ;;
    NetBSD)
      printf "   Detecting platform: installing setup on NetBSD system.\n"
      if confirm "Would you like to install neovim ?"; then
        sudo pkgin install neovim
      fi
      if confirm "Would you like to install lua and luajit ?"; then
        sudo pkgin install luajit
        sudo pkgin install lua
      fi
      if confirm "Would you like to install neovim's python librarys ?"; then
        python3 -m pip install pynvim
      fi
      if confirm "Would you like to install node ?"; then
        sudo pkgin install nodejs npm yarn
      fi
      if confirm "Would you like to install ripgrep ?"; then
        sudo pkgin install ripgrep
      fi
      ;;
    OpenBSD)
      printf "   Detecting platform: installing setup on OpenBSD system.\n"
      if confirm "Would you like to install neovim ?"; then
        doas pkg_add neovim
      fi
      if confirm "Would you like to install lua and luajit ?"; then
        doas pkg_add luajit
        doas pkg_add lua
      fi
      if confirm "Would you like to install neovim's python librarys ?"; then
        python3 -m pip install pynvim
      fi
      if confirm "Would you like to install node ?"; then
        doas pkg_add nodejs npm yarn
      fi
      if confirm "Would you like to install ripgrep ?"; then
        doas pkg_add ripgrep
      fi
      ;;
    Darwin)
      printf "   Detecting platform: installing setup on OpenBSD system.\n"
      if confirm "Would you like to install neovim ?"; then
        brew install neovim
      fi
      if confirm "Would you like to install lua and luajit ?"; then
        brew install luajit
        brew install lua
      fi
      if confirm "Would you like to install neovim's python librarys ?"; then
        python3 -m pip install pynvim
      fi
      if confirm "Would you like to install node ?"; then
        brew install nodejs npm yarn
      fi
      if confirm "Would you like to install ripgrep ?"; then
        brew install ripgrep
      fi
      if confirm "Would you like to install treesitter and lazygit ?"; then
        brew install lazygit tree-sitter
      fi
      ;;
    *)
      echo "OS :$OS is not currently supported."
      exit 1
      ;;
  esac
}

parse_arguments(){
  while [ "$#" -gt 0 ]; do
    case "$1" in
      -i | --install)
        install
        ;;
      -ib | --install-bin)
	install_bin
        ;;
      -h | --help)
	usage
        exit 0
        ;;
      -id | --install-dependencies)
	install_dependencies
        ;;
      -nd | --no-install-dependencies)
	no_install_dependencies
        ;;
    esac
    shift
  done
}

main(){
  clear
  welcome_message
  check_neovim_min_version
  backup
  install
}

main "$@"
