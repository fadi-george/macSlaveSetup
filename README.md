# Mac Jenkins Slave Setup
Setup scripts for a Jenkins slave on Mac. 

## Running
Execute setup script like so:  
```
sh setup.sh
```

### Scripts Included
The bin folder includes a variety of shell scripts to setup individual platforms.

- _setup_jenkins.sh_ setups SSH remote login, copies SSH keys to Jenkins Master, and creates a Node in Jenkins.
- _setup_xcode.sh_ downloads Xcode command lines tools and Xcode as well automatically agrees to licenses.
- _setup_ios.sh_ setups an environment to build iOS Apps with fastlane + RVM.
- _setup_android.sh_ setups an environment to build Android Apps with Android SDK/Java 8.  
- _setup_mac.sh_ setups Mac's bashrc and bash_profile files.  
- _setup_brew.sh_ downloads and updates Brew installation.  
- _setup_web.sh_ downloads aws-cli.


