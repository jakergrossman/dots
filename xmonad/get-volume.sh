#!/bin/sh

# get current sink
SINK=$( pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1)

# get volume from current sink
VOL=$( pactl list sinks | grep '^\s\+Volume:' | head -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )

# output $VOL to stdout
echo "$VOL%"
