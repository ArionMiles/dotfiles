# dotfiles

This is my dotfiles repo. There are many like it, but this one is mine.

My dotfiles are my best friend. They are my life. I must master them as I must master my life.

Without me, my dotfiles are useless. Without my dotfiles, I am ~~useless~~ less productive.

> [!CAUTION]
> Use at your own risk.
>
> Read through the code here first. Pick and choose configs you prefer, remove what you don't need.
> I wouldn't recommended running the install scripts blindly, you may end up in a confusing state on your machine.

> [!NOTE]
> The git/config contains my email, name and signing key.
>
> If you're cloning this repository, please create a new `~/gitconfig` with following parameters which git will override from my own config here:
>
> ```
> [user]
> email = <your email>
> name = <your name>
> signingkey = <your key>
> ```

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
- Install homebrew (only on macOS)
- Install tmux plugin manager
- Install AWS CLI v2

### Optional

Install/upgrade all the packages under `Brewfile` with:

```bash
brew bundle install
```

Run `./set-macos-preferences.sh` to change the defaults for a lot of stuff on MacOS.
