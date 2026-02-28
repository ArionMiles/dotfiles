# ==============================================================================
# FUNCTIONS
# ==============================================================================

function reloadfish
     for file in ~/.config/fish/**/*.fish
        source $file 
    end
end

# Kill process running on a given port
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

# Convert MKV to MP4
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

# Convert WEBM to MP4
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

# FZF previewer for writing jq queries
function jqf
    set -l file (string escape -- $argv[1])
    true | fzf --disabled --print-query \
        --preview "jq -C {q} $file 2>&1" \
        --preview-window=up:90%
end

# Use fzf to search and exec into a k8s pod
# Accepts argument for type of shell, e.g: bash, ash, etc.
# Default shell is /bin/sh
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

# Use fzf to select and describe a k8s resource
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

# Trigger a GitHub Actions workflow and wait for it to complete
# Usage: genbuild [--workflow <file>]
#   --workflow  Explicit workflow filename (skips auto-detection)
#   Auto-detects ci.yml or build.yml (in that order) if they have a workflow_dispatch trigger
function genbuild
    set workflow ""

    set i 1
    while test $i -le (count $argv)
        if test "$argv[$i]" = "--workflow"
            set i (math $i + 1)
            if test $i -le (count $argv)
                set workflow $argv[$i]
            else
                echo "genbuild: --workflow requires an argument"
                return 1
            end
        end
        set i (math $i + 1)
    end

    if test -z "$workflow"
        for candidate in ci.yml build.yml
            set wf_path ".github/workflows/$candidate"
            if test -f "$wf_path"
                if grep -q "workflow_dispatch" "$wf_path"
                    set workflow $candidate
                    break
                end
            end
        end

        if test -z "$workflow"
            echo "genbuild: no ci.yml or build.yml with a workflow_dispatch trigger found"
            echo "          use --workflow <file> to specify one explicitly"
            return 1
        end
    end

    set branch (git rev-parse --abbrev-ref HEAD)

    gh workflow run $workflow --ref $branch
    or begin
        notify "genbuild: failed to trigger $workflow on $branch"
        return 1
    end

    echo "Triggered $workflow on $branch, waiting for run to appear..."
    sleep 5

    set run_id (gh run list --workflow=$workflow --branch=$branch --limit=1 --json databaseId --jq '.[0].databaseId')
    if test -z "$run_id"
        notify "genbuild: could not find workflow run on $branch"
        return 1
    end

    echo "Watching run $run_id..."
    gh run watch $run_id

    set result (gh run view $run_id --json conclusion --jq '.conclusion')
    if test "$result" = success
        notify "genbuild: $workflow succeeded on $branch"
    else
        notify "genbuild: $workflow $result on $branch"
    end
end
