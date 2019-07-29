#!/bin/bash
# Credits:
# Setup: https://github.com/smartlyio/bootstrap/blob/5838565e396664af906aa7880326e15927d4e855/macos-slave-bootstrap.bash

source ./utils.sh

e_header "Brew Setup"

## Install Brew
if ! which -s brew; then
  echo | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update
