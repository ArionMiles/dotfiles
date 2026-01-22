# ==============================================================================
# EXPORTS
# ==============================================================================

# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Don't clear the screen after quitting a manual page.
set -gx MANPAGER 'less -X'

set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml

# Avoid issues with `gpg` as installed via Homebrew.
set -gx GPG_TTY (tty)

# Prefer US English and use UTF-8.
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8

set -gx FZF_DEFAULT_OPTS '--layout=reverse --border=bold --border=rounded --margin=3% --color=dark'
