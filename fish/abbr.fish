# ==============================================================================
# ALIASES
# ==============================================================================

# Navigation
abbr --add vi nvim

# Git & GitHub CLI
abbr --add gs git status
abbr --add vpr gh pr view -w
abbr --add cpr gh pr create

abbr --add nf 'fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {+})"'
# Index all directories inside pwd for zoxide
alias zad='find . -mindepth 1 -maxdepth 1 -type d -exec zoxide add "{}" \;'
# Print each PATH entry on a separate line
abbr --add path printf '%s\n' $PATH
# Get week number
abbr --add week date +%V

# Go
abbr --add tidy go mod tidy

# Kubernetes
abbr --add k kubectl
abbr --add kn kubectl config set-context --current --namespace
abbr --add kgp kubectl get pods -L version
abbr --add kgj kubectl get jobs -L version
abbr --add kg kubectl get
abbr --add kd kubectl describe
abbr --add kl kubectl logs

# Detect which `ls` flavor is in use and set appropriate aliases
if ls --color &>/dev/null
    # GNU ls
    set -gx LS_COLORS 'no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
    abbr --add l ls -lAF --color
    abbr --add ls ls --color
    abbr --add lsa ls -lah --color
    abbr --add ll ls -lh --color
    abbr --add la ls -lAh --color
else
    # macOS ls
    set -gx LSCOLORS BxBxhxDxfxhxhxhxhxcxcx
    abbr --add l ls -lAFG
    abbr --add ls ls -G
    abbr --add lsa ls -lahG
    abbr --add ll ls -lhG
    abbr --add la ls -lAhG
end
