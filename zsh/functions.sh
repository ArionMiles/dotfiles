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

function mkv2mp4() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: mkv2mp4 file1.mkv [file2.mkv ...]"
    return 1
  fi

  for f in "$@"; do
    if [ ! -f "$f" ]; then
      echo "mkv2mp4: '$f' not found, skipping"
      continue
    fi

    case "$f" in
      *.mkv) out="${f%.mkv}.mp4" ;;
      *)     out="${f}.mp4" ;;
    esac

    echo "Converting '$f' -> '$out'..."
    ffmpeg -i "$f" -map 0 -c copy "$out"
  done
}

function webm2mp4() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: webm2mp4 file1.webm [file2.webm ...]"
    return 1
  fi

  for f in "$@"; do
    if [ ! -f "$f" ]; then
      echo "webm2mp4: '$f' not found, skipping"
      continue
    fi

    case "$f" in
      *.webm) out="${f%.webm}.mp4" ;;
      *)      out="${f}.mp4" ;;
    esac

    echo "Converting '$f' -> '$out'..."
    ffmpeg -i "$f" -c:v copy -c:a copy "$out"
  done
}
