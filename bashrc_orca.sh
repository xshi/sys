#!/usr/bin/env bash

#--------------------------------------------------
# Prompt Setting
#--------------------------------------------------
HOST=$(hostname | cut -d. -f1)
if [ "$PS1" ]; then
  PS1="\u_$HOST$ "
  ignoreeof=1
fi

#--------------------------------------------------
# General ENV
#--------------------------------------------------
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export CVSEDITOR=vim
export PATH=$HOME/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH #for MacPorts
export LESS='-R'
export LESSOPEN='|~/.sys/lessfilter.sh %s' 

#--------------------------------------------------
# General Aliases
#--------------------------------------------------
alias l="ls"
alias ll="l -lh"
alias lsd="l -d */"
alias en="emacs -nw"
alias ec="emacsclient"
alias p="pwd"
alias rl="root -l" 
alias rm~="rm *~"

. ~/local/share/root/bin/thisroot.sh

#--------------------------------------------------
# Functions 
#--------------------------------------------------

bak(){
   if [ -z "$1" ]; then
       echo "Ocean(o) Ocean2(o2) ?"

   elif [ "$1" = "o" ]; then
       rsync -avuE -P $HOME/Documents /Volumes/Ocean/Documents
       rsync -avuE -P $HOME/Pictures /Volumes/Ocean/Pictures
       rsync -avuE -P $HOME/Movies /Volumes/Ocean/Movies
       #rsync -avuE -P /Users/xshi/Library/Application\ Support/Google/Picasa3 /Volumes/Ocean/Library/Application\ Support/Google/

   elif [ "$1" = "o2" ]; then
       rsync -avuE -P /Volumes/Ocean/ /Volumes/Ocean2/

   fi;
}


cmsdoc(){
    if [ -z "$1" ]; then
	echo "Usage: cmsdoc style fname action"
	echo "eg.: cmsdoc an AN-12-066 u"
	echo "an, dn, pas ?"
	read sty 
    else
	sty=$1
    fi

    if [ -z "$2" ]; then
	echo "Input fname: "
	echo "eg. : AN-12-066"
	read fname 
    else
	fname=$2
    fi
    
    if [ -z "$3" ]; then
	echo "[b] build"
	echo "[o] open"
	echo "[s] share"
	echo "[u] update"
	read action 
    else
	action=$3
    fi
    
    pwd=$PWD

    case $action in 
	b)  cd $HOME/work/cms/doc/tdr
	    eval `./notes/tdr runtime -sh` 
	    cd notes/$fname/trunk
	    tdr --style=$sty b $fname 
	    ;;
	o)  open $HOME/work/cms/doc/tdr/notes/tmp/$fname"_temp.pdf"
	    ;;

	s)  fn=$fname"_"`eval date +%Y%m%d`".pdf"
	    cp $HOME/work/cms/doc/tdr/notes/tmp/$fname"_temp.pdf" ~/Google\ Drive/Work/AFB/$fn
	    echo "Copied $fn to Box. "
	    ;;
	u)  cd $HOME/work/cms/doc/tdr
	    svn up notes/$fname 
	    ;;
    esac

    cd $pwd 
}




et() {
    echo "Recursively generating TAGS for *.cc *.h *.py ..."
    find . -name "*.cc" -print -or -name "*.h" -print  -or -name "*.py" -print | xargs etags
}


ki() {
    if [ -z "$1" ]; then
	echo "lepp (l) , fnal (f), cern (c) ?"
    fi;
    if [ "$1" = "l" ]; then
	kinit -f -l 7d xs32@LNS.CORNELL.EDU
    fi; 
    if [ "$1" = "f" ]; then
	kinit -f xshi@FNAL.GOV
    fi; 
    if [ "$1" = "c" ]; then
	kinit -Af -l 1d xshi@CERN.CH
    fi; 
}


ks() {
    if [ -z "$1" ]; then
	echo "lepp (l) , fnal (f), cern (c) ?"
    elif [ "$1" = "l" ]; then
	kswitch -p xs32@LNS.CORNELL.EDU
    elif [ "$1" = "f" ]; then
	kswitch -p xshi@FNAL.GOV
    elif [ "$1" = "c" ]; then
	kswitch -p xshi@CERN.CH
    fi; 
}


setsys() {
    echo -ne "Setting system ...\r"

    sudo cp ~/.sys/etc_krb5.conf /etc/krb5.conf 
    cp ~/.sys/ssh_config ~/.ssh/config 
    cp ~/.sys/dot_hgrc ~/.hgrc
    #cp ~/bak/emacs/sx-ini.el ~/.emacs.d/init.el 
    echo "Setting system ... done."
}


sl() {
    # echo "[ntu]     ntucms1.cern.ch"
    # echo "[np]      pixel_dev@ntucms1.cern.ch"
    # echo "[tb]      pixel_dev@pcpixeltb.cern.ch"
    # echo "[ps]      pixel_dev@pcp028047.psi.ch"
    # echo "[tn]      ssh xshi@lxplus5.cern.ch -L 10080:ntucms1.cern.ch:80 -N"
    # cat ~/.ssh/id_dsa.pub | ssh user@remote.com 'cat >> ~/.ssh/authorized_keys'

    hostnames=(bohr cern clyd eceg etna fnal kaut lepp rcac frie)
    
    export bohr=shi210@bohr.physics.purdue.edu
    export cern=xshi@lxplus.cern.ch
    export clyd=shi210@clyde.physics.purdue.edu
    export eceg=shi210@ecegrid.ecn.purdue.edu
    export etna=purduepix@etna.physics.purdue.edu
    export fnal=xshi@cmslpc-sl6.fnal.gov
    export kaut=xshi@kautzky.physics.purdue.edu
    export lepp=xs32@lnx235.lepp.cornell.edu
    export rcac=shi210@hep.rcac.purdue.edu
    export frie=shi210@friedman.physics.purdue.edu


    if [ -z "$1" ]; then
        for hostname in ${hostnames[*]}
	do
	    subst="$hostname"
            echo "    ["$hostname"]" ${!subst}
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
	    echo "Logging into" ${!subst} "..." 
	    ssh -Y ${!subst}
	fi 
    done
}


syn() {
    if [ -z "$1" ]; then
	echo "[1]  etna:cmspxl/dat ==> orca4"
	echo "[2]  orca4:cmspxl/dat ==> etna"
	echo "[3]  rcac:hzz2l2nu/plots ==> orca4"
	read menu 
    else
	menu=$1
    fi

    case $menu in 
	1) rsync -a -P purduepix@etna.physics.purdue.edu:~/cmspxl/dat/ ~/work/cms/pxl/cmspxl/dat/
	   ;;
	2) rsync -a -P ~/work/cms/pxl/cmspxl/dat/ purduepix@etna.physics.purdue.edu:~/cmspxl/dat/ 
	   ;;
	3) rsync -a -P shi210@hep.rcac.purdue.edu:/home/shi210/cmssw/CMSSW_7_2_2/src/UserCode/llvv_fwk/test/phojet/plots/ ~/work/cms/hzz/2l2v_fwk/test/phojet/plots/
	   ;;
    esac
}

function tabname {
  printf "\e]1;$1\a"
}
 
function winname {
  printf "\e]2;$1\a"
}

