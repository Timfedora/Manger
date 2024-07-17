#!/bin/bash

clear

echo "This is the ejecting script from Manager"
echo "This script requires root privileges to eject drives"

# Prompt for password
echo "Enter your laptop's password"
sudo -v  # Prompt for sudo password and keep alive throughout script

# List available block devices
echo "Available block devices:"
lsblk -o NAME

# Prompt user to enter the drive name
read -p "Enter the name of the drive you want to eject (e.g., sda1): " drive_name

# Check if the drive name is provided
if [ -z "$drive_name" ]; then
    echo "Error: Drive name not provided."
    exit 1
fi

# Check if the drive exists
if [ ! -e "/dev/$drive_name" ]; then
    echo "Drive /dev/$drive_name does not exist."
    exit 1
fi

# Eject the drive
echo "Ejecting /dev/$drive_name ..."
sudo eject "/dev/$drive_name"

# Check if eject was successful
if [ $? -ne 0 ]; then
    echo "Failed to eject /dev/$drive_name"
    exit 1
fi

echo "Drive ejected successfully."


