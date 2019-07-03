#!/bin/bash

source=$1
silenced="${1%.*}-silenced.mp3"
stretched="${1%.*}-stretched.mp3"
compressed="${1%.*}-compressed.mp3"

sox -S $source $silenced silence 1 0.1 0.5% -1 0.1 0.5%
sox -S $silenced $stretched tempo 1.2
sox -S $stretched $compressed speed 1.2

#mid3iconv $compressed -e utf-8 --remove-v1

rm $silenced
rm $stretched