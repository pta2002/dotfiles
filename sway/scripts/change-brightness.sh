#!/usr/bin/env bash

DIR=`dirname $BASH_SOURCE`

BRIGHT=`brightnessctl s $1 | awk 'NR==3 {print $4}' | tr -d \(\)\%`

$DIR/notify-send.sh "Brightness: $BRIGHT%" \
  --replace-file=/tmp/brightness-notification \
  -t 1000 \
  -h int:value:${BRIGHT} \
  -h string:synchronous:brightness-change
