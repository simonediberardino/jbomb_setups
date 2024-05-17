#!/bin/bash

# Ensure the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 
    exec sudo "$0" "$@"
    exit 1
fi

# Set variables
REPO_URL="https://github.com/simonediberardino/BomberMan/releases/latest/download/JBomb.jar"
FILENAME="bin/JBomb.jar"

# Create the bin directory if it doesn't exist
if [ ! -d "bin" ]; then
    mkdir -p "bin"
fi

# Display ASCII art bomb
echo "======================================================================"
echo
echo "                   JBomb Game Updater"
echo
echo "This prompt will download the latest version of JBomb. Ensure you have"
echo "an active internet connection."
echo
echo "======================================================================"
echo

# Download the file with progress bar
echo "Downloading JBomb update..."
curl -L -o "$FILENAME" --progress-bar "$REPO_URL"

if [ $? -ne 0 ]; then
    echo "Download failed."
    exit 1
fi

echo
echo "Download completed successfully."
echo "JBomb has been updated to the latest version."

# Pause
read -p "Press any key to continue..."
