#!/bin/bash
# Send notification
osascript -e 'display notification "'"$1"'" with title "Claude Code" sound name "Blow"'

# Bring Ghostty to front
osascript -e 'tell application "Ghostty" to activate'
