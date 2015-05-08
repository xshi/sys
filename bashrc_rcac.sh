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
#export DISPLAY=hep.rcac.purdue.edu:0.0 

#--------------------------------------------------
# Settings for CMS 
#--------------------------------------------------
source /cvmfs/cms.cern.ch/cmsset_default.sh

alias setgrid='source /grp/cms/tools/glite/setup.sh'
alias voc='voms-proxy-init -voms cms -valid 168:0'
alias voi='voms-proxy-info'
alias setcrab2='source /grp/cms/crab/crab.sh'
alias setcrab='source /cvmfs/cms.cern.ch/crab3/crab.sh'

#--------------------------------------------------
# Functions 
#--------------------------------------------------

batch_kill() {
    pgrep $1 | awk '{print  "kill -9 "$1}' | sh  
}

ki() {
    if [ -z "$1" ]; then
	echo "fnal (f) ?"
    fi;

    if [ "$1" = "f" ]; then
	kinit -f xshi@FNAL.GOV
    fi; 
}

# setgrid() {
#     echo -ne "Setting grid ...\r"
#     source /grp/cms/tools/glite/setup.sh 
#     source /grp/cms/crab/crab.sh
# #    alias voc='voms-proxy-init -voms cms -valid 168:0'
# #    alias voi='voms-proxy-info'
# #    echo "Enabled voc and voi."
#     echo "Setting grid ... done."
# }

clsrm() {
    if [ -z "$1" ]; then
	echo "Clearning up ALL files in the current directory? [N/y] ?"
	read a 
	if [ "$a" = "y" ]; then
	    for f in `ls -l | awk '{printf("%s ", $9)}'`;
	    do
		echo $f;
		srmrm srm://srm.rcac.purdue.edu:8443/srm/v2/server?SFN=$(pwd)/$f;
	    done
	fi;
    else
	echo "Removing empty dir " $(pwd)/$1 "..."
	srmrmdir srm://srm.rcac.purdue.edu:8443/srm/v2/server?SFN=$(pwd)/$1	
    fi;
}


lsHLT() {
    if [ -z "$1" ]; then
	printf "NAME\n\tlsHLT - list HLT menu\n"
	return 
    fi;
    edmProvDump $1 | sed -n '/^Processing History/,/^----/p' | grep HLT 
    #tmpline=`edmProvDump $1 | sed -n '/^Processing History/,/^----/p' | grep HLT `
}

lsTable() {
    if [ -z "$1" ]; then
	printf "NAME\n\tlsTable - list HLT tableName\n"
	printf "EXAMPLE\n\tlsTable input.root -i 93287157e65f618f37e0483d88\n"
	return 
    fi;
    edmProvDump $1 -i $2 | grep tableName
}
