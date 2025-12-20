alias bat="batcat"
alias vi="nvim"
alias gs="git status"
alias nf='fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {+})"'
alias zad="ls -d */ | xargs -I {} zoxide add {}"
