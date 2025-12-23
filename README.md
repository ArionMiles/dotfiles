# dotfiles

This is my dotfiles repo. There are many like it, but this one is mine. 

My dotfiles are my best friend. They are my life. I must master them as I must master my life. 

Without me, my dotfiles are useless. Without my dotfiles, I am ~~useless~~ less productive.

> [!CAUTION]
> Read through the code here first. Pick and choose configs you prefer, remove what you don't need. 
> I wouldn't recommended running the install scripts blindly, you may end up in a confusing state on your machine. Use at your own risk.

> [!NOTE]
> Please edit the following files if you are cloning/forking this repository:
> * git/config [`user.email`, `user.name`, and `user.signingkey`]

## Setup

1. Clone the repo
  ```bash
  git clone https://github.com/ArionMiles/dotfiles
  ```
2. Run the script:
  ```bash
  ./bootstrap.sh
  ```

  The script will:
  - Symlink all the dotfiles into appropriate directories
  - Install homebrew (only on macOS and if homebrew is not already installed)
  - Install oh-my-zsh, zsh-autosuggestions, and tmux plugin manager (if these aren't already installed)
  - Install AWS CLI v2 (if not already installed)


### Optional

Install/upgrade all the packages under `Brewfile` with:
```bash
brew bundle install
```

## Credits

 - A few ideas here are inspired from my good friend [oxalorg/dotfiles](https://github.com/oxalorg/dotfiles)
 - Installation scripts are inspired by [andrew8088/dotfiles](https://github.com/andrew8088/dotfiles)

