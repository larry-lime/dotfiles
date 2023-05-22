#!/bin/zsh
if [[ $GCLI == false ]]; then
  eval "$(github-copilot-cli alias -- "$0")"
fi 
GCLI=true
