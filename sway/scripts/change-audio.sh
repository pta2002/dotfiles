#!/usr/bin/env bash

DIR=`dirname $BASH_SOURCE`

if [ "$1" == "-t" ]; then
  pamixer $1

  if pamixer --get-mute > /dev/null; then
    # It's muted
    $DIR/notify-send.sh "Muted" \
      --replace-file=/tmp/audio-notification \
      -t 1000 \
      -h int:value:0 \
      -h string:synchronous:volume-change
    exit
  fi
else
  pamixer $1 $2
fi

VOLUME=`pamixer --get-volume`

$DIR/notify-send.sh "Volume: $VOLUME%" \
  --replace-file=/tmp/audio-notification \
  -t 1000 \
  -h int:value:${VOLUME} \
  -h string:synchronous:volume-change
