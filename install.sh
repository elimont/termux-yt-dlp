#!/data/data/com.termux/files/usr/bin/bash

BLUE='\e[34m'
NC='\e[0m'
YTDLP_CONFIG_FOLDER="${HOME}/.config/yt-dlp/"
TERMUXURLOPENER_CONFIG_FOLDER="${HOME}/bin/"

echo "Hi, This script setup an environment to download various videos from various apps"
sleep 1
echo -e "\n\n${BLUE}Requirements:${NC}"
echo "    1. Allow storage access to Termux."
echo "    2. A working internet connection."
read -p "When you are ready just press enter:"

# Basic setup
termux-setup-storage
sleep 5
pkg update
pkg install python ffmpeg
pip install -U pip
pip install -U wheel
pip install -U yt-dlp
mkdir -p $TERMUXURLOPENER_CONFIG_FOLDER
cp -r -u $YTDLP_CONFIG_FOLDER ~/.config/
cp termux-url-opener "${TERMUXURLOPENER_CONFIG_FOLDER}/"

echo -e "${BLUE}Congratulations!!! Your setup is complete.${NC}\n\n"
