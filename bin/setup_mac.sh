#!/bin/bash

# Create files if they don't exist
touch ~/.bash_profile
touch ~/.bashrc

# Source bashrc for login terminal sessions
if ! grep -q "source ~/.bashrc" ~/.bash_profile; then
    ## pre-pend line to top of bash_profile
    echo 'source ~/.bashrc' | cat - ~/.bash_profile > temp && mv temp ~/.bash_profile
fi
