# dotfiles

These are my dotfiles. There are many like it, but this one is mine. 

My dotfiles are my best friend. They are my life. I must master them as I must master my life. 

Without me, my dotfiles are useless. Without my dotfiles, I am ~~useless~~ less productive.

## Setup

1. Clone into your $HOME
  ```bash
  git clone https://github.com/ArionMiles/dotfiles ~
  ```
2. Either run the below command that will execute `setup.sh` for every sub-directory or you may manually run setup for the directories you need to install.
  ```bash
  cd dotfiles
  bash setup.sh
  ```

### Optional

Use the `Brewfile` to install/upgrade all packages
```bash
brew bundle install
```

> [!NOTE]
> Please edit the following files if you are cloning/forking this repository:
> * git/config [`user.email`, `user.name`, and `user.signingkey`]

## Credits

A few ideas here are inspired from my good friend [oxalorg's dotfiles](https://github.com/oxalorg/dotfiles)
