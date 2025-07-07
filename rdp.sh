#!/bin/bash

## Ubuntu 24.04 RDP access after system reboot
## Unlock keyring on autologin and set RDP username and password

# SET UP YOUR NODE

# Enable SSH connection 
# $sudo apt install openssh-server
# $sudo systemctl enable ssh

# Install GNOME Extension Manager
# $sudo apt-get update
# $sudo apt install gnome-shell-extension-manager
# Using Extension Manager - Install "Allow Locked Remote Desktop"

# Install keyring manager for SSH 
# $sudo apt install gnome-keyring
# $gnome-keyring-daemon --start

# Settings > Users > Enable Automatic Login
# Settings > Power > Set Screen Blank to 1 minutes for added security after reboot

# Set default RDP values or enter new ones
RdpUser=defaultuser
RdpPass=defaultpassword

# Start script
echo -e "\n\nEnter Ubuntu Login Password"
read -s login_password;

echo "Enter RDP username [$RdpUser]"
read rdpusername;
rdpusername=${rdpusername:-$RdpUser};

echo "Enter RDP password [$RdpPass]"
read -s rdppassword;
rdppassword=${rdppassword:-$RdpPass};

echo -e "\n\nUnlocking KeyRing ..."
echo -n "$login_password" | gnome-keyring-daemon --replace --unlock

echo -e "\nSetting RDP Credentials ..."
grdctl rdp set-credentials $rdpusername $rdppassword

echo -e "Restarting RDP ...\n"
systemctl --user stop gnome-remote-desktop.service
systemctl --user start gnome-remote-desktop.service

