#!/bin/bash
# Credits:
# Remote Login: https://apple.stackexchange.com/questions/278744/command-line-enable-remote-login-and-remote-management
# SSH copy id: https://stackoverflow.com/a/48797250
# API Tokens: https://stackoverflow.com/a/53767188
# Serial number: https://apple.stackexchange.com/a/40244
# create node api: https://gist.github.com/Evildethow/be4614ba27882d8f4627a972a624d525

source "$(dirname "$0")"/utils.sh

load_env
e_header "SSH/Jenkins Slave Setup"

## Enable Remote Login
sudo systemsetup -setremotelogin on

if [ ! -d ~/.ssh ]; then
  ## Setup ssh keys
  mkdir ~/.ssh
  echo y | ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N "${KEYPHRASE}"
fi

## Copy to Authorized Keys in Remote (Jenkins Master)
if ask "Copy ssh keys to Jenkins authorized keys?" N; then
  echo y | ssh-copy-id -i ~/.ssh/id_rsa.pub ${JENKINS_HOST_USER}@$JENKINS_URL
fi

## Set up Jenkins Slave Node
if ask "Setup Slave Node on Jenkins?" N; then
  echo "Checking for CSRF..."
  CRUMB=$(curl --fail -0 -u "${JENKINS_USER}:${JENKINS_API_TOKEN}" ''"${JENKINS_URL}"'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)' 2>/dev/null || echo "N/A")
  if [[ ${CRUMB} == "N/A" ]]; then
    e_error "Could not get Jenkins Crumb."
  fi

  # Create node (doCreateItem)
  SERIAL_NUMBER=$(ioreg -l | awk '/IOPlatformSerialNumber/ { print $4;}' | xargs)
  NODE_NAME="Mac - ${SERIAL_NUMBER}"
  USERNAME=$(id -un)
  IP_ADDRESS=$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}')

  JSON_OBJECT='{
    "name": "'"${NODE_NAME}"'",
    "nodeDescription": "",
    "numExecutors": "4",
    "remoteFS": "'"/Users/${USERNAME}/Documents/jenkins"'",
    "labelString": "android be ios mac qa web",
    "mode": "EXCLUSIVE",
    "": ["hudson.plugins.sshslaves.SSHLauncher", "hudson.slaves.RetentionStrategy$Always"],
    "launcher": {
      "stapler-class": "hudson.plugins.sshslaves.SSHLauncher",
      "$class": "hudson.plugins.sshslaves.SSHLauncher",
      "host": "'"${IP_ADDRESS}"'",
      "credentialsId": "'"${JENKINS_LOGIN_CREDENTIALS}"'",
      "": "2",
      "sshHostKeyVerificationStrategy": {
        "requireInitialManualTrust": false,
        "stapler-class": "hudson.plugins.sshslaves.verifiers.ManuallyTrustedKeyVerificationStrategy",
        "$class": "hudson.plugins.sshslaves.verifiers.ManuallyTrustedKeyVerificationStrategy"
      },
      "port": "22"
    },
    "retentionStrategy": {
      "stapler-class": "hudson.slaves.RetentionStrategy$Always",
      "$class": "hudson.slaves.RetentionStrategy$Always"
    },
    "nodeProperties": {
      "stapler-class-bag": "true"
    },
    "type": "hudson.slaves.DumbSlave",
    "Jenkins-Crumb": "'"${CRUMB}"'"
  }'

  RESPONSE=$(curl -L -s -o /dev/null -w "%{http_code}" \
    -u "${JENKINS_USER}:${JENKINS_API_TOKEN}" \
    -H "Content-Type:application/x-www-form-urlencoded" -H "${CRUMB}" \
    -X POST -d "json=${JSON_OBJECT}" \
    "${JENKINS_URL}/computer/doCreateItem?type=hudson.slaves.DumbSlave" --data-urlencode "name=${NODE_NAME}")

  if [[ ${RESPONSE} == "200" ]]; then
    echo "Successfully added node. "
  else
    e_error "Could not add slave."
  fi
fi

