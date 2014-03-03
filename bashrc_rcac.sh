#!/bin/sh


export HOST=$(hostname | cut -d. -f1)
export USER=${USER:-$(whoami)}

if [ "$PS1" ]; then
  # Set auto_resume if you want TWENEX style behaviour for command names.
  auto_resume=

  # Set notify if you want to be asynchronously notified about background
  # job completion.
  notify=

  # Make it so that failed `exec' commands do not flush this shell.
  no_exit_on_failed_exec=

  #export HOST=$(hostname | cut -d. -f1)
  #export USER=${USER:-$(whoami)}
  export EDITOR=vim
  #export MAIL=/usr/spool/mail/$USER


  #if [ ! "$LOGIN_SHELL" ]; then
  PS1="\u_$HOST> "
  #fi

  HISTSIZE=256
  MAILCHECK=60

  xtitle() {
    if [ $# -gt 1 ]; then
      echo -e "\033]1;$1\a\c"
      echo -e "\033]2;$2\a\c"
    else
      echo -e "\033]0;$1\a\c"
    fi
  }

  cd_xtitle() {
    xtitle "$USER@$HOST" "$HOST $PWD"
  }

  [ "$TERM" = "xterm" ] && PROMPT_COMMAND=cd_xtitle
  [ -n "$DISPLAY"     ] && export GKS3Dconid=$DISPLAY

  pwd() {
    if [ "${nolinks+set}" = "set" ] ; then
      builtin pwd
    else
      echo "$PWD"
    fi
  }

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

# settings for CMS 
source /cvmfs/cms.cern.ch/cmsset_default.sh
source /grp/cms/tools/glite/setup.sh 
source /grp/cms/crab/crab.sh 

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


