#!/bin/sh

clear

echo "This is the DD script from Manager"

echo "This script requires root privileges to eject drives"

# Prompt for password
echo "Enter your laptop's password"
sudo -v

echo "Warning: This script will wipe the drive you are targeting"
echo "Do you want to proceed? (Y/n)"
read -r choice

choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

if [ "$choice" = "n" ]; then
    echo "Operation canceled. Exiting..."
    exit 1
fi

echo "Please enter the path for your file"
read -r path
echo

lsblk -o NAME

echo "Please enter the USB drive path (e.g., /dev/sdX):"
read -r usbdrivepath

# Check if the USB drive path exists
if [ ! -b "$usbdrivepath" ]; then
    echo "Error: USB drive path '$usbdrivepath' does not exist or is not a block device."
    exit 1
fi

# Perform the DD operation with progress and sync
sudo dd if="$path" of="$usbdrivepath" bs=4M status=progress && sync

echo ""
echo "========= SUCCESS ==========="
echo ""
