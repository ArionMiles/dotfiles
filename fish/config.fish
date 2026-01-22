# Fish shell configuration
source "$HOME/.env.sh"

eval (/opt/homebrew/bin/brew shellenv)

starship init fish | source # https://starship.rs/
zoxide init --cmd cd fish | source # 'ajeetdsouza/zoxide'
fzf --fish | source

set -U fish_greeting # disable fish greeting

# fzf git bindings
source $DOTFILES/scripts/fzf-git.fish

# Source non-tracked extras (generally work related config)
if test -e $DOTFILES/fish/extras.fish
    source $DOTFILES/fish/extras.fish
end
