#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ -f $DIR/autorun-desktop.sh ]]; then
    sh $DIR/autorun-desktop.sh
fi

picom --backend glx --experimental-backends
