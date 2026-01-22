# ==============================================================================
# PATH
# ==============================================================================

# User bins
fish_add_path $HOME/bin $HOME/.local/bin /usr/local/bin

# Add GNU coreutils, sed, and findutils to PATH (Homebrew on macOS)
if test -n "$HOMEBREW_PREFIX"
    fish_add_path $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
    fish_add_path $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin
    fish_add_path $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin
end

# Neovim
fish_add_path /opt/nvim-linux-x86_64/bin
