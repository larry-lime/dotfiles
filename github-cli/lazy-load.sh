#!/bin/zsh

# check if github copilot is installed
if ! command -v github-copilot-cli &> /dev/null
then
    echo "github-copilot-cli could not be found"
    exit 1
fi

if [[ $GCLI == false ]]; then
    eval "$(github-copilot-cli alias -- "$0")"
fi
GCLI=true
