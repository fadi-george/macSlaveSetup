#!/usr/bin/env bash
# Credits:
# Setup: https://github.com/smartlyio/bootstrap/blob/5838565e396664af906aa7880326e15927d4e855/macos-slave-bootstrap.bash
# Setup: https://github.com/Provenance-Emu/Provenance/blob/36a52f2b2dc2d359da0efd0b59c863283224736d/Scripts/carthage.sh
# Xcode license: https://apple.stackexchange.com/a/213151

source "$(dirname "$0")"/utils.sh

if ! which -s brew; then
  echo "Brew is required"
  exit 1
fi

e_header "Xcode Setup"

echo "Checking assistive access"
if ! osascript -e 'tell application "System Events" to click at {0,0}' 2>/dev/null; then
  echo "Enable assistive access for Terminal"
  osascript -e '
    tell app "System Preferences"
      activate
      set current pane to pane "com.apple.preference.security"
    end tell'
  sleep 2
fi

## Download command line tools
xcode-select -p &> /dev/null
if [ $? -ne 0 ]; then
  xcode-select --install
  sleep 1

  osascript -e '
    tell application "System Events"
      tell process "Install Command Line Developer Tools"
        keystroke return
        click button "Agree" of window "License Agreement"
        delay 1
        keystroke return
        repeat
          delay 5
          if exists (button "Done" of window 1) then
            click button "Done" of window 1
            exit repeat
          end if
        end repeat
      end tell
    end tell'
fi

## Download Xcode
brew install mas
mas install 497799835 # Xcode

# accept Xcode license agreements
sudo xcodebuild -license accept
