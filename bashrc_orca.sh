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
#export PATH=/usr/local/bin:$PATH
export PATH=$HOME/local/bin:$PATH
#export PATH=/opt/local/bin:/opt/local/sbin:/Applications/CMake.app/Contents/bin:$PATH #for MacPorts 
export PATH=/usr/local/Cellar/ruby/2.5.1/bin:$PATH


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
#alias sr="ssh -R 52698:127.0.0.1:52698" 
alias sd="ssh -D 9999 xshi@lxplus.cern.ch"
alias jk="bundle exec jekyll serve"

#. ~/local/share/root/bin/thisroot.sh
. ~/local/share/root-6.10.06/build/bin/thisroot.sh 

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
    hostnames=(cern cepc ihep ihep5 lepp pixel emc)
    
 
    export cern=xshi@lxplus.cern.ch
    export cepc=shixin@cepcvtx.ihep.ac.cn
    export ihep=shixin@lxslc6.ihep.ac.cn
    export ihep5=shixin@lxslc5.ihep.ac.cn

    export pixel=shixin@192.168.28.247 
    export emc=shixin@192.168.28.246 

    export lepp=xs32@lnx201.classe.cornell.edu


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

function tabname {
  printf "\e]1;$1\a"
}
 
function winname {
  printf "\e]2;$1\a"
}



