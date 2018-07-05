if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.api_tokens ]; then
    . ~/.api_tokens
fi

if [ -f ~/.ps1 ]; then
    . ~/.ps1
else
    #prompt
    _PS1 ()
    {
        local PRE= NAME="$1" LENGTH="$2";
        [[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
            PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
        ((${#NAME}>$LENGTH)) && NAME="/..${NAME:$[${#NAME}-LENGTH+4]}";
        echo "$PRE$NAME"
    }

    HOSTNAME=$(hostname -s)
    export PS1='\[\033[1;92m\]\u@$HOSTNAME\[\033[0m\] \[\033[1;94m\]$(_PS1 "$PWD" 30)$\[\033[0m\] '
fi

export CLICOLOR=1
export LSCOLORS=Exgxcxdxcxegedabagacad

export TERM=xterm-256color

export PATH="$PATH:/Users/mfirmin/bin"

source ~/dotfiles/.git-completion.bash

eval $(thefuck --alias)

if [[ $TMUX ]]; then source ~/.tmux-git/tmux-git.sh; fi

# MacPorts Installer addition on 2017-01-11_at_10:51:45: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
