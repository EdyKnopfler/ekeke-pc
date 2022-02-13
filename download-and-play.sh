#!/bin/bash
FILE=/tmp/youtube.webm
set +e
rm $FILE
set -e
URL=$(xclip -selection c -o)
./yt-dlp -f 250+242 -o $FILE "$URL"
mpv $FILE
