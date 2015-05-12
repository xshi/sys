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
alias screen='TERM=screen screen' # remove the Wuff!
alias sr='screen -r' 

#--------------------------------------------------
# General ENV
#--------------------------------------------------
export CVS_RSH=ssh
export CVSEDITOR=vim
export PATH=$HOME/local/bin:$PATH
export LESS='-R'
export LESSOPEN='|~/.sys/lessfilter.sh %s' 
unset SSH_ASKPASS  

#--------------------------------------------------
# Settings for CMS 
#--------------------------------------------------
source /cvmfs/cms.cern.ch/cmsset_default.sh

alias setgrid='source /grp/cms/tools/glite/setup.sh'
alias voc='voms-proxy-init -voms cms -valid 168:0'
alias voi='voms-proxy-info'
alias setcrab='source /cvmfs/cms.cern.ch/crab3/crab.sh'

#--------------------------------------------------
# Functions 
#--------------------------------------------------

batch_kill() {
    pgrep $1 | awk '{print  "kill -9 "$1}' | sh  
}

clsrm() {
    if [ -z "$1" ]; then
	printf "NAME\n\tclsrm - Clear SRM files\n"
	return 
    fi

    if [ -d "$1" ]; then 
 	echo "Clearning up ALL files in the dir $1. Are you sure? [N/y]"
	read a 
	if [ "$a" != "y" ]; then
	    echo "Please type y to proceed. Quit."
	    return
	fi
	
	for f in $(find ./ -type f);
	do
	    echo $f;
	    srmrm srm://srm.rcac.purdue.edu:8443/srm/v2/server?SFN=$(pwd)${f:1};
	done
	
	echo "Removing empty dir $1..."
	srmrmdir srm://srm.rcac.purdue.edu:8443/srm/v2/server?SFN=$(pwd)/$1
    else
	for f in "$@"
	do
	    echo "Removing file $f ..."
	    srmrm srm://srm.rcac.purdue.edu:8443/srm/v2/server?SFN=$(pwd)/$f;	    
	done
    fi;
}


lsHLT() {
    if [ -z "$1" ]; then
	printf "NAME\n\tlsHLT - list HLT menu\n"
	return 
    fi;
    str=`edmProvDump $1 | sed -n '/^Processing History/,/^----/p' | grep HLT | cut -d "(" -f2 | cut -d ")" -f1`
    edmProvDump $1 -i $str | grep tableName 
}







