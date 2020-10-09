#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

picom --backend glx --experimental-backends

type $DIR/autorun-desktop.sh && $DIR/autorun-desktop.sh
type $DIR/autorun-laptop.sh && $DIR/autorun-laptop.sh
