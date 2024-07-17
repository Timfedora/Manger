#!/bin/bash

clear 

echo "This is the CD-drive script from Manager"
echo "This script requires root privileges to mount drives"

echo "Enter your laptop's password"
sudo -v

mount_dir="/mnt/mydrive"

if [ ! -d "$mount_dir" ]; then
    echo "Creating mount directory: $mount_dir"
    sudo mkdir -p "$mount_dir"
fi

echo "Available block devices:"
lsblk -o NAME

read -p "Enter the name of the drive you want to mount (e.g., sda1): " drive_name

if [ ! -e "/dev/$drive_name" ]; then
    echo "Drive $drive_name does not exist."
    exit 1
fi

echo "Mounting /dev/$drive_name to $mount_dir ..."
sudo mount "/dev/$drive_name" "$mount_dir"
if [ $? -ne 0 ]; then
    echo "Failed to mount /dev/$drive_name to $mount_dir"
    exit 1
fi

echo "Drive mounted successfully to $mount_dir"

if ! cd "$mount_dir"; then
    echo "Failed to change directory to $mount_dir"
    exit 1
fi

exec "$SHELL"






