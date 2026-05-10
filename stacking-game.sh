#!/bin/sh
printf '\033c\033]0;%s\a' stacking-game
base_path="$(dirname "$(realpath "$0")")"
"$base_path/stacking-game.x86_64" "$@"
