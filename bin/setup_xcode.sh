#!/usr/bin/env bash
# Credits:
# Setup: https://github.com/smartlyio/bootstrap/blob/5838565e396664af906aa7880326e15927d4e855/macos-slave-bootstrap.bash
# Setup: https://github.com/Provenance-Emu/Provenance/blob/36a52f2b2dc2d359da0efd0b59c863283224736d/Scripts/carthage.sh
# Xcode license: https://apple.stackexchange.com/a/213151

source "$(dirname "$0")"/bin/utils.sh

## Brew Installs Command Line Tools
if ! which -s brew; then
  echo "Brew is required"
  exit 1
fi

e_header "Xcode Setup"

## Download Xcode
brew install mas
mas install 497799835 # Xcode

# accept Xcode license agreements
sudo xcodebuild -license accept
