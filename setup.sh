#!/bin/bash -i

# Ask for Pass early
sudo -v

# Setup configs
cd ./bin
source setup_mac.sh
source setup_brew.sh
source setup_android.sh
source setup_xcode.sh
source setup_web.sh
source setup_be.sh
source setup_qa.sh
bash setup_ios.sh
source setup_slave.sh

exit 0
