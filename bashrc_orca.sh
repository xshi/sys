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
export PATH=/opt/local/bin:/opt/local/sbin:/Applications/CMake.app/Contents/bin:$PATH #for MacPorts 
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
alias cdoutlook="cd /Users/xshi/Library/Group\ Containers/UBF8T346G9.Office/Outlook/Outlook\ 15\ Profiles/Main\ Profile/Data/Message\ Attachments"

. ~/local/share/root/bin/thisroot.sh

#--------------------------------------------------
# Functions 
#--------------------------------------------------

bak(){
   if [ -z "$1" ]; then
       echo "Ocean(o) Ocean2(o2) Ocean3(o3)?"

   elif [ "$1" = "o" ]; then
       rsync -avuE -P $HOME/Documents /Volumes/Ocean/Documents
       rsync -avuE -P $HOME/Pictures /Volumes/Ocean/Pictures
       rsync -avuE -P $HOME/Movies /Volumes/Ocean/Movies

   elif [ "$1" = "o2" ]; then
       rsync -avuE -P /Volumes/Ocean/ /Volumes/Ocean2/

   elif [ "$1" = "o3" ]; then
       rsync -avuE -P $HOME/Documents /Volumes/Ocean3/Documents
       rsync -avuE -P $HOME/Pictures /Volumes/Ocean3/Pictures
       rsync -avuE -P /Volumes/Ocean/Pictures/Photos\ Library.photoslibrary /Volumes/Ocean3/Pictures/Photos\ Library.photoslibrary
       rsync -avuE -P $HOME/Movies /Volumes/Ocean3/Movies

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
	    cp $HOME/work/cms/doc/tdr/notes/tmp/$fname"_temp.pdf" $HOME/Desktop/$fn
	    echo "Copied $fn to Desktop. "
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
    hostnames=(cern fnal lepp)
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

    case $menu in
	lepp) kinit -f -l 7d xs32@LNS.CORNELL.EDU
	      ;;
	fnal) kinit -f xshi@FNAL.GOV
	      ;;
	cern) kinit -Af -l 1d xshi@CERN.CH
	      ;;
    esac
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
    echo "Setting system ... done."
}


sl() {
    # echo "[tn]      ssh xshi@lxplus5.cern.ch -L 10080:remote.cern.ch:80 -N"
    # cat ~/.ssh/id_dsa.pub | ssh user@remote.com 'cat >> ~/.ssh/authorized_keys'
    #hostnames=(bohr cern clyd eceg etna fnal frie ihep kaut lepp rcac)
    hostnames=(cern fnal ihep ihep5 lepp pixel emc)
    
    #export bohr=shi210@bohr.physics.purdue.edu
    export cern=xshi@lxplus.cern.ch
    #export clyd=shi210@clyde.physics.purdue.edu
    #export eceg=shi210@ecegrid.ecn.purdue.edu
    #export etna=purduepix@etna.physics.purdue.edu
    export fnal=xshi@cmslpc-sl6.fnal.gov
    #export frie=shi210@friedman.physics.purdue.edu
    export ihep=shixin@lxslc6.ihep.ac.cn
    export ihep5=shixin@lxslc5.ihep.ac.cn
    export pixel=shixin@192.168.28.247 
    export emc=shixin@192.168.28.246 
    #export kaut=xshi@kautzky.physics.purdue.edu
    #export lepp=xs32@lnx235.lepp.cornell.edu
    export lepp=xs32@lnx201.classe.cornell.edu
    #export rcac=shi210@hep.rcac.purdue.edu


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
	echo "[1]  ihep:bes/jpsi2invi/v0.1/run/hist ==> orca4"
	echo "[2]  orca4:cmspxl/dat ==> etna"
	echo "[3]  rcac:hzz2l2nu/plots ==> orca4"
	read menu 
    else
	menu=$1
    fi

    case $menu in 
	1) rsync -a -P shixin@lxslc5.ihep.ac.cn:~/bes/jpsi2invi/v0.1/run/hist/ ~/bes/jpsi2invi/v0.1/run/hist/ 
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



