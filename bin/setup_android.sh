#!/bin/bash
source "$(dirname "$0")"/utils.sh
e_header "Android Setup"

# Load variables if present
source ~/.bashrc

if ! which -s brew; then
  echo "Brew is required"
  exit 1
fi

# Get Java 8
brew tap adoptopenjdk/openjdk
brew cask install adoptopenjdk8
java -version

brew cask install android-sdk

# Set Android Environment
if [ -z "${ANDROID_HOME}" ]; then
  echo 'export ANDROID_HOME="/usr/local/share/android-sdk"' >> ~/.bashrc
fi

# Reload Terminal session
source ~/.bashrc

touch ~/.android/repositories.cfg
yes | sdkmanager --licenses && sdkmanager --update
