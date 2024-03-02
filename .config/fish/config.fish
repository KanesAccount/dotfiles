set -Ux EDITOR nvim

# Setup aliases for commands that I use often
alias orgs='sf org list --all'
alias lg='lazygit'
alias scratch='sh ./scripts/booknow/newscratch.sh $1'
alias ll='eza -al'
alias zbn='z BookNow-'

# Setup abbreviations for commands that take variable args
abbr bi "brew install"
abbr bic "brew install --cask"
abbr bin "brew info"
abbr binc "brew info --cask"
abbr bs "brew search"
abbr n nvim

# ordered by priority - bottom up
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.config/bin # my custom scripts

# Go bin for running go programs
set -x GOPATH "$HOME/go"
fish_add_path $GOPATH/bin
#fish_add_path /opt/homebrew/anaconda3/bin # anaconda

## Nap Config 
# Configuration
export NAP_CONFIG="~/.config/nap/config.yaml"
export NAP_HOME="~/.config/nap"
export NAP_DEFAULT_LANGUAGE="go"
export NAP_THEME="nord"

# Colors
export NAP_PRIMARY_COLOR="#AFBEE1"
export NAP_RED="#A46060"
export NAP_GREEN="#527251"
export NAP_FOREGROUND="7"
export NAP_BACKGROUND="0"
export NAP_BLACK="#373B41"
export NAP_GRAY="240"
export NAP_WHITE="#FFFFFF"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
