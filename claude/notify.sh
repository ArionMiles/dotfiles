#!/bin/bash
MESSAGE="$1"

# Read CWD from hook JSON payload (stdin), fall back to pwd
if [ ! -t 0 ]; then
    STDIN=$(cat)
    CWD=$(echo "$STDIN" | jq -r '.cwd // empty' 2>/dev/null)
fi
if [ -z "$CWD" ]; then
    CWD="$(pwd)"
fi

# Send notification
osascript -e 'display notification "'"$MESSAGE"'" with title "Claude Code" sound name "Blow"'

# Focus the Ghostty terminal matching this session's working directory
osascript <<EOF
tell application "Ghostty"
    set windowList to every window
    repeat with i from (count of windowList) to 1 by -1
        set w to item i of windowList
        set termList to every terminal of w
        repeat with j from (count of termList) to 1 by -1
            set t to item j of termList
            if working directory of t is "$CWD" and name of t starts with "✳" then
                focus t
                return
            end if
        end repeat
    end repeat
    activate
end tell
EOF
