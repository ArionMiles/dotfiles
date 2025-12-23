source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}

source_if_exists $HOME/.env.sh

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Add GNU coreutils, sed, and findutils to PATH
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Create the .zcompdump files under this directory so ~ is clean
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

source_if_exists $DOTFILES/zsh/aliases.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# neovim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export EDITOR="nvim"
export VISUAL="nvim"

# Setup pyenv if found
if command -v pyenv > /dev/null 2>&1; then
	eval "$(pyenv init -)"
fi

# Set up fzf if found
if command -v fzf > /dev/null 2>&1; then
  source <(fzf --zsh)
  export FZF_DEFAULT_OPTS="--layout=reverse --border=bold --border=rounded --margin=3% --color=dark"
  source $DOTFILES/scripts/fzf-git.sh
fi

# Setup zoxide if found
if command -v zoxide > /dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# Setup kube-ps1 if found and not already set
if command -v kubectl > /dev/null 2>&1 && [ -f "$DOTFILES/scripts/kube-ps1.sh" ] && ! typeset -f kube_ps1 >/dev/null; then
  source "$DOTFILES/scripts/kube-ps1.sh"
  KUBE_PS1_HIDE_IF_NOCONTEXT=true
  # Add kube-ps1 to right prompt
  RPROMPT='$(kube_ps1)'$RPROMPT
fi

# Setup aws-ps1 if found and not already set
if command -v aws > /dev/null 2>&1 && [ -f "$DOTFILES/scripts/aws.zsh" ] && ! typeset -f aws_prompt_info >/dev/null; then
  source "$DOTFILES/scripts/aws.zsh"
fi

# Setup kubectl autocomplete if found
if command -v kubectl > /dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

# kubejumper shell integration
[ -f $HOME/.config/kubejumper/kubejumper.sh ] && source $HOME/.config/kubejumper/kubejumper.sh


# Open a tmux session by default
if command -v tmux >/dev/null 2>&1; then
  # If not already inside a tmux session
  if [ -z "$TMUX" ]; then
    # Try to attach to an existing session named 'default'
    tmux attach-session -t default || tmux new-session -s default
  fi
fi

# GPG key signing doesn't work on ghostty without this set.
GPG_TTY=$(tty)
export GPG_TTY

# Set Locale
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8


# Source any .sh files from $DOTFILES/work/ directory (depth 1 only)
if [ -d "$DOTFILES/work" ]; then
  for file in "$DOTFILES/work"/*.sh; do
    [ -f "$file" ] && source "$file"
  done
fi
