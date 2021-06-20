#!/bin/bash

HELP=${1}

function usage() {
  echo "This script gonna presents and execute a selection of scripts"
  exit 1
}

if [[ "${HELP}" =~ "-h" ]]; then
  usage
fi

read -p "Which script do you want to execute ? :
1- Folder Rearranger
2- Garbage Remover
" CHOICE

case "$CHOICE" in
1)
  echo "Folder Rearranger selected"
  ./folder_rearranger.sh
  ;;
2)
  echo "Garbage Remover selected"
  ./garbage_remover.sh
  ;;
*)
  echo "Invalid selection - aborting"
  exit 1
  ;;
esac
