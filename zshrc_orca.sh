#!/usr/bin/env zsh

#--------------------------------------------------
# Prompt Setting
#--------------------------------------------------
HOST=$(hostname | cut -d. -f1)
if [ "$PS1" ]; then
  PS1="%n_$HOST$ "
  ignoreeof=1
fi

#--------------------------------------------------
# General ENV
#--------------------------------------------------
#export LANG=en_US
#export LC_CTYPE="utf-8"

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export CVSEDITOR=vim
export PATH=$HOME/local/bin:$PATH
# For MacPort: 
export PATH=/opt/local/bin:$PATH
# Ruby 
export PATH=/usr/local/opt/ruby/bin:$PATH
# Python 
export PATH=$HOME/Library/Python/3.9/bin:$PATH 

#--------------------------------------------------
# General Aliases
#--------------------------------------------------
alias l="ls"
alias ll="l -lh"
alias lsd="l -d */"

alias p="pwd"
alias rm~="rm *~"
alias sd="ssh -D 9999 xshi@lxplus.cern.ch"
alias si="ssh -D 9999 shixin@lxslc7.ihep.ac.cn"
alias sk="networksetup -setsocksfirewallproxystate Wi-Fi"
alias jk="bundle exec jekyll serve" 
alias mk="mkdocs serve" 


#--------------------------------------------------
# Functions 
#--------------------------------------------------

bak(){
   if [ -z "$1" ]; then
       echo "Ocean(o) Ocean3(o3)?"

   elif [ "$1" = "o" ]; then
       rsync -avuE -P $HOME/Documents /Volumes/Ocean/Documents
       rsync -avuE -P $HOME/Pictures /Volumes/Ocean/Pictures
       rsync -avuE -P $HOME/Movies /Volumes/Ocean/Movies

   elif [ "$1" = "o3" ]; then
       rsync -avuE -P $HOME/Documents /Volumes/Ocean3/Documents
       rsync -avuE -P $HOME/Pictures /Volumes/Ocean3/Pictures
       rsync -avuE -P $HOME/Movies /Volumes/Ocean3/Movies
   fi;
}


sl() {
    hostnames=(cern ihep)
    export cern=xshi@lxplus.cern.ch
    export ihep=shixin@lxslc7.ihep.ac.cn
    if [ -z "$1" ]; then
        for hostname in ${hostnames[*]}
	do
	    subst="$hostname"
            echo "    ["$hostname"]" ${(P)subst}  #zsh 
	done
   	read menu 
    else
    	menu=$1
    fi
    
    for hostname in ${hostnames[*]}
    do
	subst="$hostname"
	if [[ $menu == $hostname ]];
	then
	    echo "Logging into" ${(P)subst} "..." 
	    ssh -Y ${(P)subst} 
	fi 
    done
}
