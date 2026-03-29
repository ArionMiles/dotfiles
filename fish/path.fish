# ==============================================================================
# PATH
# ==============================================================================

# User bins
fish_add_path $HOME/bin $HOME/.local/bin /usr/local/bin

# Add GNU coreutils to PATH (Homebrew on macOS)
if test -n "$HOMEBREW_PREFIX"
    fish_add_path $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
end

# Neovim
fish_add_path /opt/nvim-linux-x86_64/bin

# Added by Obsidian
fish_add_path /Applications/Obsidian.app/Contents/MacOS
