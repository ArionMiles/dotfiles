
# # ==============================================================================
# # FUNCTIONS
# # ==============================================================================

function reloadfish
     for file in ~/.config/fish/**/*.fish
        source $file 
    end
end

# # Kill process running on a given port
function killp
    lsof -ti :$argv[1] | xargs kill -9
end

# # Upload from clipboard to x0.at and copy URL back to clipboard
function pbtxt
    pbpaste | curl -F 'file=@-' https://x0.at/ | tee (pbcopy)
end

function pbpng
    pngpaste - | curl -F 'file=@-;filename=clipboard.png' https://x0.at/ | tee (pbcopy)
end

# # Convert MKV to MP4
function mkv2mp4
    if test (count $argv) -lt 1
        echo "Usage: mkv2mp4 file1.mkv [file2.mkv ...]"
        return 1
    end

    for f in $argv
        if not test -f $f
            echo "mkv2mp4: '$f' not found, skipping"
            continue
        end

        set out $f
        switch $f
            case '*.mkv'
                set out (string replace -r '\.mkv$' '.mp4' $f)
            case '*'
                set out "$f.mp4"
        end

        echo "Converting '$f' -> '$out'..."
        ffmpeg -i "$f" -map 0 -c copy "$out"
    end
end

# # Convert WEBM to MP4
function webm2mp4
    if test (count $argv) -lt 1
        echo "Usage: webm2mp4 file1.webm [file2.webm ...]"
        return 1
    end

    for f in $argv
        if not test -f $f
            echo "webm2mp4: '$f' not found, skipping"
            continue
        end

        set out $f
        switch $f
            case '*.webm'
                set out (string replace -r '\.webm$' '.mp4' $f)
            case '*'
                set out "$f.mp4"
        end

        echo "Converting '$f' -> '$out'..."
        ffmpeg -i "$f" -c:v copy -c:a copy "$out"
    end
end

# # Remind you of something after a delay
function remindme
    if test (count $argv) -lt 2
        echo "Usage: remindme 'in 5hrs' 'your reminder message'"
        return 1
    end

    set timedesc $argv[1]
    set message $argv[2..-1]

    # Parse time: extract number and unit
    set num (echo $timedesc | grep -oE '[0-9]+')
    set unit (echo $timedesc | sed 's/in//g' | sed 's/[0-9]//g' | sed 's/[[:space:]]//g' | tr '[:upper:]' '[:lower:]')

    # Map unit to seconds multiplier
    set secs_per_unit 1
    switch $unit
        case 's' 'sec'
            set secs_per_unit 1
        case 'm' 'min'
            set secs_per_unit 60
        case 'h' 'hr' 'hrs'
            set secs_per_unit 3600
        case 'd' 'day' 'days'
            set secs_per_unit 86400
        case '*'
            echo "Unsupported unit: $unit (use sec/min/hrs/days)"
            return 1
    end

    set total_secs (math "$num * $secs_per_unit")

    # Fire in background
    fish_run_bg sleep $total_secs; and notify "$message"
end

# FZF previewer for writing jq queries
function jqf
    set -l file (string escape -- $argv[1])
    true | fzf --disabled --print-query \
        --preview "jq -C {q} $file 2>&1" \
        --preview-window=up:90%
end

# # Use fzf to search and exec into a k8s pod
# # Accepts argument for type of shell, e.g: bash, ash, etc.
# # Default shell is /bin/sh
function kexecf
    set shell_cmd /bin/sh
    if test (count $argv) -gt 0
        set shell_cmd $argv
    end

    set pod (kubectl get pods -o name \
        | fzf --tmux center,60%,border-native \
              --border-label "exec -it" \
              --header "Select pod:" \
              --header-border rounded \
              --bind 'tab:down,btab:up' \
        | awk '{print $1}')

    if test -z "$pod"
        echo "No pod selected."
        return 1
    end

    kubectl exec -it "$pod" -- $shell_cmd
end

# # Use fzf to select and describe a k8s resource
function kdf
    if test -z "$argv[1]"
        echo "Usage: kdf <api-resource>"
        echo "Run 'kubectl api-resources' to list available resources."
        return 1
    end

    set resource $argv[1]
    set val (kubectl get "$resource" -o name \
        | fzf --tmux center,60%,border-native \
              --border-label "Describe $resource" \
              --header "Select $resource:" \
              --header-border rounded \
              --bind 'tab:down,btab:up' \
        | awk '{print $1}')

    if test -z "$val"
        echo "No $resource selected."
        return 1
    end

    kubectl describe "$val"
end
