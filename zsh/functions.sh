#!/usr/bin/env bash

# Kill process running on a given port
function killp() {
    lsof -i :$1 | awk 'NR>1 {print $2}' | xargs kill -9
}

# Upload from your clipboard using pbpaste to x0.at and get back the URL and copy it into pbcopy
function pbtxt() {
    pbpaste | curl -F 'file=@-' https://x0.at/ | tee >(pbcopy)
}

function pbpng() {
    pngpaste - | curl -F 'file=@-;filename=clipboard.png' https://x0.at/ | tee >(pbcopy)
}
