#!/bin/bash
URL=$(xclip -selection c -o)
vlc $(./yt-dlp -gf 18 --cookies /tmp/cookie.txt  "$URL")
