#!/bin/bash -i

# Ask for Pass early
sudo -v

# Setup configs
source ./bin/setup_mac.sh
source ./bin/setup_brew.sh
source ./bin/setup_android.sh
source ./bin/setup_xcode.sh
source ./bin/setup_web.sh
source ./bin/setup_be.sh
source ./bin/setup_qa.sh
source ./bin/setup_ios.sh
source ./bin/setup_slave.sh

exit 0
