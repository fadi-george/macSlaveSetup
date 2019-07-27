#!/bin/bash
source "$(dirname "$0")"/bin/utils.sh
e_header "Web App Setup"

# Load variables if present
source ~/.bashrc

if ! which -s brew; then
  echo "Brew is required"
  exit 1
fi

## Install aws cli
brew install awscli