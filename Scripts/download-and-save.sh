#!/bin/bash
URL=$(xclip -selection c -o)
./yt-dlp -f 18 -o "$HOME/Vídeos/%(title)s.%(ext)s" "$URL"
