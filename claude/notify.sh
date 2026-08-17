#!/bin/bash
MESSAGE="$1"
SOUND="${2:-Blow}"

# Drain stdin (hook JSON payload) so it doesn't hang or leak into the shell.
if [ ! -t 0 ]; then
    cat >/dev/null
fi

# Send notification
osascript -e 'display notification "'"$MESSAGE"'" with title "Claude Code" sound name "'"$SOUND"'"'

# Bring Ghostty to the front (no tab-matching/highlighting).
osascript -e 'tell application "Ghostty" to activate'
