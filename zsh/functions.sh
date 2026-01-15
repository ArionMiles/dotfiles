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

# Doesn't work during sleep.
remindme() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: remindme 'in 5hrs' 'your reminder message'"
    return 1
  fi

  local timedesc="$1"
  shift
  local message="$*"

  # Parse time: extract number and unit
  local num="${timedesc//[^0-9]/}"
  local unit="${timedesc//[0-9]/}"
  unit="${unit//in/}"
  unit="${unit// /}"
  unit=$(echo $unit | tr '[:upper:]' '[:lower:]')

  # Map unit to seconds multiplier
  local secs_per_unit
  case $unit in
    s|sec) secs_per_unit=1 ;;
    m|min) secs_per_unit=60 ;;
    h|hr|hrs) secs_per_unit=3600 ;;
    d|day|days) secs_per_unit=86400 ;;
    *) echo "Unsupported unit: $unit (use sec/min/hrs/days)"; return 1 ;;
  esac

  local total_secs=$(( num * secs_per_unit ))

  # Fire in background
  (
    sleep $total_secs
    notify "$message"
  ) &>/dev/null &
}

# fzf previewer for writing jq queries
function jqf() { : | fzf --disabled --print-query --preview "jq -C {q} \"$1\" 2>&1" --preview-window=up:90%; }

# Use fzf to search and exec into a k8s pod.
# Accepts argument for type of shell, e.g: bash, ash, etc.
# Default shell is /bin/sh -- This is almost universal so guaranteed to work
# even in the absence of an argument.
# Expected kubectl context & namespace to already be set.
function kexecf() {
  local shell_cmd=("$@")
  if [[ ${#shell_cmd[@]} -eq 0 ]]; then
    shell_cmd=(/bin/sh)
  fi

  local pod
  pod=$(kubectl get pods -o name |\
   fzf --tmux center,60%,border-native \
            --border-label "exec -it" \
            --header "Select pod:" \
            --header-border rounded \
            --bind 'tab:down,btab:up'\
   | awk '{print $1}'
   )

  if [[ -z "$pod" ]]; then
    echo "No pod selected."
    return 1
  fi

  kubectl exec -it "$pod" -- "${shell_cmd[@]}"
}

 function kdf() {
  if [[ -z "$1" ]]; then
    echo "Usage: kdf <api-resource>"
    echo "Run 'kubectl api-resources' to list available resources."
    return 1
  fi

  local resource="$1"
  local val
  val=$(kubectl get "$resource" -o name |\
   fzf --tmux center,60%,border-native \
            --border-label "Describe ${resource}" \
            --header "Select ${resource}:" \
            --header-border rounded \
            --bind 'tab:down,btab:up'\
   | awk '{print $1}'
   )

  if [[ -z "$val" ]]; then
    echo "No ${resource} selected."
    return 1
  fi

  kubectl describe "$val"
 }
