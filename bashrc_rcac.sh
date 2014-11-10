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
#source /grp/cms/tools/glite/setup.sh 
#source /grp/cms/crab/crab.sh 
alias voi='voms-proxy-init -voms cms -valid 168:0'

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

sethbb() {
    echo -ne "Setting hbb ...\r"
    export hbb=$HOME/work/cms/hbb
    export rel=$hbb/rel/CMSSW_5_3_9/src
    cd $rel ;  eval `scram runtime -sh` 
    export build=$rel/HbbAna/BprimeTobH
    export test=$build/test 
    echo "Setting hbb ... done."
}

