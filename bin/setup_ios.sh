#!/bin/bash
# NOTE: Call with `bash ./setup_ios.sh`
# Credits:
# RVM: https://www.engineyard.com/blog/how-to-install-ruby-on-a-mac-with-chruby-rbenv-or-rvm

source ./utils.sh
e_header "iOS Setup"

# Load variables if present
source ~/.bashrc

if ! which -s brew; then
  echo "Brew is required"
  exit 1
fi

## Setup Fastlane
brew install cocoapods
brew cask install fastlane

if ! cmd_exists "fastlane"; then
  echo 'export PATH=$HOME/.fastlane/bin:$PATH' >> ~/.bashrc
fi

if ! cmd_exists "rvm"; then
  \curl -L https://get.rvm.io | bash
fi
if ! grep -q "\$HOME/.rvm/scripts/rvm" ~/.bashrc; then
  echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
fi

# Reload Terminal session
source ~/.bashrc

# Get latest Ruby
rvm use ruby --install --default

rvm -v
ruby -v

## Install bundler (v2)
gem install bundler
bundler -v
