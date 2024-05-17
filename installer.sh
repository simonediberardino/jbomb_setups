#!/bin/bash

# Ensure the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 
    exec sudo "$0" "$@"
    exit 1
fi

# Set variables
REPO_URL_JBOMB="https://github.com/simonediberardino/BomberMan/releases/latest/download/JBomb.jar"
REPO_URL_UPDATER="https://github.com/simonediberardino/jbomb_setups/releases/latest/download/updater.sh"
INSTALL_DIR="/usr/local/bin/jbomb"
FILENAME_JBOMB="JBomb.jar"
FILENAME_UPDATER="updater.sh"
DESKTOP_LINK="$HOME/Desktop/JBomb"

# Create the installation directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
fi

# Display ASCII art bomb
echo "======================================================================"
echo
echo "                   JBomb Game Installer"
echo
echo "This prompt will download and install the latest version of JBomb"
echo "and its updater. Ensure you have an active internet connection."
echo
echo "======================================================================"
echo

# Download the JBomb jar file with progress bar
echo "Downloading JBomb..."
curl -L -o "$INSTALL_DIR/$FILENAME_JBOMB" --progress-bar "$REPO_URL_JBOMB"

if [ $? -ne 0 ]; then
    echo "Download of JBomb failed."
    exit 1
fi

# Download the updater script with progress bar
echo "Downloading updater script..."
curl -L -o "$INSTALL_DIR/$FILENAME_UPDATER" --progress-bar "$REPO_URL_UPDATER"

if [ $? -ne 0 ]; then
    echo "Download of updater script failed."
    exit 1
fi

# Set executable permissions for the updater script
chmod +x "$INSTALL_DIR/$FILENAME_UPDATER"

echo
echo "Download completed successfully."
echo "JBomb and its updater have been installed to the latest version."

# Create a symbolic link to the JBomb jar file on the desktop
if [ -e "$DESKTOP_LINK" ]; then
    rm "$DESKTOP_LINK"  # Remove existing link if it exists
fi

ln -s "$INSTALL_DIR/$FILENAME_JBOMB" "$DESKTOP_LINK"

if [ $? -ne 0 ]; then
    echo "Failed to create a symbolic link on the desktop."
    exit 1
fi

echo "A symbolic link to JBomb has been created on your desktop."

# Pause
read -p "Press any key to continue..."
