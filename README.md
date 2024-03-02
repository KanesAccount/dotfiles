# dotfiles
dotfiles for my preferred development setup

## Requirements 

### Git 

```bash
brew install git
```

### Stow

```bash
brew install stow
```

## Installation

Checkout the dotfiles repo into the $HOME directory using git clone

```bash
git clone https://github.com/KanesAccount/dotfiles.git
cd dotfiles
```
Then use GNU Stow to symlink the dotfiles into the home directory

```bash
stow .
```

