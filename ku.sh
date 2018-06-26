#!/bin/bash
ffmpeg -i test.mp3 -af silenceremove=1:0:-80dB output.mp3
