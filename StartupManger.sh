#!/bin/bash

clear

echo "This is the manager setup script"
echo "This script needs root to install the software needed in the manager script"
echo

# Prompt for password and keep sudo session alive
echo "Enter your laptop's password"
sudo -v  # Prompt for sudo password and keep alive throughout script

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
    elif [ -f /etc/debian_version ]; then
        OS="debian"
    elif [ -f /etc/redhat-release ]; then
        if grep -qi "fedora" /etc/redhat-release; then
            OS="fedora"
        else
            OS="centos"
        fi
    else
        OS=$(uname -s)
    fi
}

install_packages() {
    detect_distro

    case "$OS" in
        "ubuntu" | "debian")
            sudo apt update
            sudo apt install -y bpytop tilix ranger pv
            ;;
        "fedora")
            sudo dnf update
            sudo dnf install -y bpytop tilix ranger pv
            ;;
        "arch")
            sudo pacman -Syu --noconfirm
            sudo pacman -S --noconfirm bpytop tilix ranger pv
            ;;
        "centos" | *"centos"*)
            if command -v dnf &>/dev/null; then
                sudo dnf update
                sudo dnf install -y bpytop tilix ranger pv
            else
                sudo yum update
                sudo yum install -y bpytop tilix ranger pv
            fi
            ;;
        "opensuse-leap")
            sudo zypper refresh
            sudo zypper install -y bpytop tilix ranger pv
            ;;
        *)
            echo "Unsupported Linux distribution: $OS"
            exit 1
            ;;
    esac
}

install_packages

echo "Setting executable permissions for scripts..."
for script in Manger.sh Mounting.sh DD.sh CD-drive.sh Eject.sh Decompress.sh; 
do
    if [ -f "$script" ]; then
        chmod +x "$script"
    else
        echo "Warning: $script not found."
    fi
done

echo "Setup completed successfully."
echo 
echo
echo
echo " You can now start the Manger script by doing ./Manger.sh




