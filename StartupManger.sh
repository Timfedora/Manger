#!/bin/bash

clear

echo "This is the manager setup script"
echo "This script needs root to install the software needed in the manager script"
echo

# Prompt for password and keep sudo session alive
echo "Enter your laptop's password"
sudo -v  # Prompt for sudo password and keep alive throughout script

# Check if script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi

# Install required packages
echo "Installing bpytop, ranger, and tilix..."
sudo dnf install bpytop ranger tilix -y

# Check installation status
if [ $? -ne 0 ]; then
    echo "Failed to install one or more packages. Exiting."
    exit 1
fi

# Set executable permissions
echo "Setting executable permissions for scripts..."
chmod +x Manger.sh
chmod +x Mounting.sh
chmod +x DD.sh
chmod +x CD-drive.sh
chmod +x Eject.sh
chmod +x Decompress.sh

echo "Setup completed successfully."



