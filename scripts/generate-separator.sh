#!/bin/bash

# Check if figlet is installed
if ! command -v figlet &>/dev/null; then
  echo "figlet could not be found, please install it first."
  exit 1
fi

# Function to generate a comment separator
generate_separator() {
  local text="$@"
  # modify the next line to capitalize all the letters without using figlet
  local figletOutput=$(echo "$@" | tr '[:lower:]' '[:upper:]')
  # local figletOutput=$(figlet -f cybermedium "$text")
  local maxLength=$(echo "$figletOutput" | awk '{ if (length($0) > max) max = length($0); } END { print max }')
  local line=$(printf '%*s' "$maxLength" | tr ' ' '-')

  # Output to stdout and copy to clipboard
  {
    echo "$line"
    echo "$figletOutput"
    echo "$line"
  } | tee >(pbcopy)
}

# Call the function with provided argument
generate_separator "$@"
