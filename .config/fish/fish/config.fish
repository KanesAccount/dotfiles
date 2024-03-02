alias push='sfdx force:source:push -f'
alias pull='sfdx force:source:pull'
alias orgs='sfdx org:list --all --skip-connection-status'
alias lg='lazygit'
alias q='exit'
alias scratch='sh ./scripts/booknow/newscratch.sh $1'
alias ll='ll -a'
alias zbn='z BookNow-'

# ordered by priority - bottom up
fish_add_path /opt/homebrew/bin # https://brew.sh/
fish_add_path /opt/homebrew/sbin
# fish_add_path /opt/homebrew/opt/sqlite/bin
# fish_add_path /opt/homebrew/opt/openjdk/bi
# fish_add_path $PNPM_HOME
fish_add_path $HOME/.local/bin
fish_add_path $GOPATH/bin
fish_add_path $HOME/.config/bin # my custom scripts

# fish_add_path $HOME/.config/tmux/plugins/tmux-nvr/bin
# fish_add_path $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin
#fish_add_path $HOME/opt/homebrew/anaconda3/bin/conda # conda - remove this since im not using it atm


if status is-interactive
    # Commands to run in interactive sessions can go here
end
