#!/bin/bash
source "$(dirname "$0")"/utils.sh

if ask "Remove Android SDKs?" N; then
  brew cask uninstall android-sdk
fi

if ask "Remove iOS setup?" N; then
  gem uninstall bundler
  rvm implode
fi

if ask "Remove brew?" N; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
fi
