#!/data/data/com.termux/files/usr/bin/bash

BLUE='\e[34m'
NC='\e[0m'
YTDLP_CONFIG_FOLDER="${HOME}/.config/yt-dlp/"
TERMUXURLOPENER_CONFIG_FOLDER="${HOME}/bin/"

echo "Hi, This script sets up an environment to download various videos from various apps."
sleep 1
echo -e "\n\n${BLUE}Requirements:${NC}"
echo "    1. Allow storage access to Termux."
echo "    2. A working internet connection."
read -p "When you are ready, press enter:"

# Basic setup
termux-setup-storage
sleep 5
pkg update
pkg install -y python python-dev clang make libffi-dev openssl-dev libxml2-dev libxslt-dev
pkg install -y ffmpeg
LDFLAGS="-L/system/lib/" CFLAGS="-I/data/data/com.termux/files/usr/include/" pip install --upgrade pip
pip install wheel
pip install yt-dlp
mkdir -p $TERMUXURLOPENER_CONFIG_FOLDER
cp -r -u $YTDLP_CONFIG_FOLDER ~/.config/
cp termux-url-opener "${TERMUXURLOPENER_CONFIG_FOLDER}/"

echo -e "${BLUE}Congratulations!!! Your setup is complete.${NC}\n\n"
