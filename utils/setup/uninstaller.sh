#!/usr/bin/bash

DVIM_RUNTIME_DIR="${DVIM_RUNTIME_DIR:-$HOME/.local/share/domacsvim}"
DVIM_CONFIG_DIR="${DVIM_CONFIG_DIR:-$HOME/.config/dvim}"
DVIM_CACHE_DIR="${DVIM_CACHE_DIR:-$HOME/.cache/dvim}"

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

main(){
  if confirm "Do you want to delete backups ?"; then
    rm -rf "$DVIM_RUNTIME_DIR.old"
    echo " Deleted $DVIM_RUNTIME_DIR.old"
    rm -rf "$DVIM_CACHE_DIR.old"
    echo " Deleted $DVIM_CACHE_DIR.old"
    rm -rf "$DVIM_CONFIG_DIR.old"
    echo " Deleted $DVIM_CONFIG_DIR.old"
  fi
  if confirm "Do you want to delete DomacsVim ?"; then
    rm -rf "$DVIM_RUNTIME_DIR"
    echo " Deleted $DVIM_RUNTIME_DIR"
    rm -rf "$HOME/.local/bin/dvim"
    echo " Deleted $HOME/.local/bin/dvim"
  fi
}

main "$@"
