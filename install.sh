#!/data/data/com.termux/files/usr/bin/bash

BLUE='\e[34m'
NC='\e[0m'
YTDLP_CONFIG_FOLDER="${HOME}/.config/yt-dlp/"
TERMUXURLOPENER_CONFIG_FOLDER="${HOME}/bin/"
OUTPUT_DIR="/sdcard/Download"

# Check if a URL was provided as an argument
if [[ $# -ne 1 ]]; then
    echo "Error: No URL provided"
    exit 1
fi

echo "Hi, This script sets up an environment to download various videos from various apps."
sleep 1

# Check if required packages are installed
if ! command -v python >/dev/null 2>&1; then
    echo "Python is not installed. Installing python..."
    yes | pkg install python
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
    echo "FFmpeg is not installed. Installing ffmpeg..."
    yes | pkg install ffmpeg
fi

# Check if storage permission is granted
if [ ! -d "$HOME/storage" ]; then
    echo -e "${BLUE}Please grant storage access to Termux by going to Settings > Apps > Termux > Permissions > Storage.${NC}"
    exit 1
fi

echo -e "\n\n${BLUE}Requirements:${NC}"
echo "    1. Allow storage access to Termux."
echo "    2. A working internet connection."
read -p "When you are ready just press enter:"

# Basic setup
termux-setup-storage
sleep 5
pkg update
pip install -U pip
pip install -U wheel
pip install -U yt-dlp
mkdir -p $TERMUXURLOPENER_CONFIG_FOLDER
cp -r -u $YTDLP_CONFIG_FOLDER ~/.config/
cp termux-url-opener "${TERMUXURLOPENER_CONFIG_FOLDER}/"

echo -e "Downloading video...\\n>URL: ${1}\\n"

# Determine if the URL is a playlist or channel
if [[ "$1" =~ .*/playlist.* ]] || [[ "$1" =~ .*list=.* ]]; then
    OUTPUT_FORMAT="%(extractor)s/playlists/%(playlist_title)s_%(playlist_id)s/%(playlist_index)03d - %(uploader)s_%(channel_id)s - %(title)s [%(id)s].%(ext)s"
    echo "Playlist detected"
else
    OUTPUT_FORMAT="%(extractor)s/%(uploader)s_%(channel_id)s/%(title)s [%(id)s].%(ext)s"
    echo "Channel detected"
fi

# Download the video with options for subtitles, metadata, and output directory
yt-dlp --embed-subs --embed-metadata --write-sub --write-auto-sub \
       -o "$OUTPUT_DIR/$OUTPUT_FORMAT" \
       --format 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' \
       "$1"

echo -e "${BLUE}Download complete.${NC}\n\n"
