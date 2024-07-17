#!/bin/bash

clear  

echo "This is the Mounting script from Manager"

echo "This script requires root privileges to mount drives"

# Prompt for password and keep sudo session alive
echo "Enter your laptop's password"
sudo -v  # Prompt for sudo password and keep alive throughout script

# Check if script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi

mount_dir="/mnt/mydrive"
if [ ! -d "$mount_dir" ]; then
    echo "Creating mount directory: $mount_dir"
    sudo mkdir -p "$mount_dir"
fi

echo "Available block devices:"
lsblk -o NAME

read -p "Enter the name of the drive you want to mount (e.g., sda1): " drive_name

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

echo "Mounting /dev/$drive_name to $mount_dir ..."
sudo mount "/dev/$drive_name" "$mount_dir"
if [ $? -ne 0 ]; then
    echo "Failed to mount /dev/$drive_name to $mount_dir"
    exit 1
fi

echo "Drive mounted successfully to $mount_dir"
