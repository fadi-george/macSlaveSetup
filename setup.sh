#!/bin/bash -i

# Ask for Pass early
sudo -v

# Setup configs
source ./bin/setup-mac.sh
source ./bin/setup-brew.sh
source ./bin/setup-slave.sh
source ./bin/setup-xcode.sh
source ./bin/setup-web.sh
source ./bin/setup-be.sh
source ./bin/setup-qa.sh
source ./bin/setup-android.sh
source ./bin/setup-iOS.sh

exit 0
