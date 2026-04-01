#!/bin/bash
MESSAGE="$1"
CWD="$(pwd)"

# Send notification
osascript -e 'display notification "'"$MESSAGE"'" with title "Claude Code" sound name "Blow"'

# Focus the Ghostty terminal matching this session's working directory
osascript <<EOF
tell application "Ghostty"
    repeat with w in every window
        repeat with t in every terminal of w
            if working directory of t is "$CWD" then
                focus t
                return
            end if
        end repeat
    end repeat
    activate
end tell
EOF
