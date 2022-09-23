#!/bin/sh


#--------------------------------------------------
# Prompt Setting
#--------------------------------------------------
HOST=$(hostname | cut -d. -f1)
if [ "$PS1" ]; then
  PS1="\u_$HOST$ "
  ignoreeof=1
fi


#--------------------------------------------------
# General Aliases
#--------------------------------------------------
alias ls="ls -h --color"
alias lsd="ls -d */"
alias l="ls"
alias ll="ls -lh"
alias p="pwd"
alias rm~="rm *~"
alias rl="root -l"
alias qs="qstat -u shixin"

#--------------------------------------------------
# General ENV
#--------------------------------------------------
export CVS_RSH=ssh
export CVSEDITOR=vim
export PATH=$HOME/local/bin:$PATH 
export SINGULARITY_CACHEDIR=$HOME/.singularity 
unset SSH_ASKPASS  

#--------------------------------------------------
# Functions 
#--------------------------------------------------

batch_kill() {
    pgrep $1 | awk '{print  "kill -9 "$1}' | sh  
}

setpyroot() {
    echo "Setting up python 2.7.11 and ROOT 5.34..."
    export PYTHONPATH=$HOME/local/lib
    export LD_LIBRARY_PATH=$HOME/local/lib
    export PATH=$HOME/local/root/bin:$PATH
    source $HOME/local/root/bin/thisroot.sh 
}


