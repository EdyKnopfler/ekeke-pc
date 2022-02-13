#!/bin/bash
URL=$(xclip -selection c -o)
mplayer -fs -cookies -cookies-file /tmp/cookie.txt \
    $(./yt-dlp -gf 18 --cookies /tmp/cookie.txt  "$URL")
