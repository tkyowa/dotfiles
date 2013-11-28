# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
function share_history {
    history -a
    history -c
    history -r
}

PROMPT_COMMAND='share_history'
shopt -u histappend

export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth

alias ll='ls -lh --color=tty --time-style=long-iso'

if [ -f ~/.bashrc_local ]; then
  source ~/.bashrc_local
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
