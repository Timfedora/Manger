#!/bin/bash

clear
echo "This is the manager script"
echo "This script can be run as either root or non-root"
echo "If you would like to run it as root, use 'su' or 'sudo -i'"
echo

echo "1. Option 1 (File management)"
echo "2. Option 2 (Resource management)"
echo "3. Option 3 (Disk management)"
echo "4. Option 4 (System info)"
echo "5. Option 5 (Terminal)"
echo "6. Option 6 (Other)"

read -p "Enter your choice (1-6): " choice

if [[ "$choice" == "1" ]]; then
    ranger
elif [[ "$choice" == "2" ]]; then
    bpytop
elif [[ "$choice" == "3" ]]; then
    echo "1. Option 1 (DD flash from file)"
    echo "2. Option 2 (CD to a drive)"
    echo "3. Option 3 (Eject a drive)"
    echo "4. Option 4 (Mount a drive)"

    read -p "Enter your choice (1-4): " choice_disk

    if [[ "$choice_disk" == "1" ]]; then
        ./DD.sh
    elif [[ "$choice_disk" == "2" ]]; then
        ./CD-drive.sh
    elif [[ "$choice_disk" == "3" ]]; then
        ./Eject.sh
    elif [[ "$choice_disk" == "4" ]]; then
        ./Mounting.sh
    else
        echo "Invalid choice. Please enter a number between 1 and 4."
    fi

elif [[ "$choice" == "4" ]]; then
    uname -a
    hostnamectl

elif [[ "$choice" == "5" ]]; then
    tilix

elif [[ "$choice" == "6" ]]; then
    echo "1. Option 1 (File uncompressing)"
    echo "2. Option 2 (Detailed system information)"
    echo "3. Option 3 (Find a file)"
    read -p "Enter your choice (1-3): " choice_other

    if [[ "$choice_other" == "1" ]]; then
        ./Decompress.sh
    elif [[ "$choice_other" == "2" ]]; then
        lsusb
        lspci -k
        uname -a
    elif [[ "$choice_other" == "3" ]]; then
        ./Finder.sh
    else
        echo "Invalid choice. Please enter a number between 1 and 3."
    fi

else
    echo "Invalid choice. Please enter a number between 1 and 6."
fi
