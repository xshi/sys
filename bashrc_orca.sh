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
       echo "Documents(d), Ocean(o), Pictures(p), Movies(v) ?"

   elif [ "$1" = "d" ]; then
       rsync -avuE -P $HOME/Documents $backup 

   elif [ "$1" = "o" ]; then
       rsync -avuE -P /Volumes/Ocean/ /Volumes/Ocean2/

   elif [ "$1" = "p" ]; then
       rsync -avuE -P /Users/xshi/Library/Application\ Support/Google/Picasa3 /Volumes/Ocean/Library/Application\ Support/Google/

   elif [ "$1" = "v" ]; then
       rsync -avuE -P $HOME/Movies $backup 
   fi;
}


cmsdoc(){
   if [ -z "$1" ]; then
	echo "[1] AN-12-066"
	echo "[2] AN-12-119"
	echo "[3] BPH-11-009"
	read menu 
    else
	menu=$1
    fi
 
    if [ -z "$2" ]; then
	echo "[b] build"
	echo "[o] open"
	echo "[s] share"
	echo "[u] update"
	read action 
    else
	action=$2
    fi
    
    case $menu in 
	1)  fname="AN-12-066"
	    sty="an"
	    ;;
	2)  fname="AN-12-119"
	    sty="an"
	    ;;
	3)  fname="BPH-11-009"
	    sty="pas"
	    ;;
	*)  fname=$menu
	    sty="pas"
	    ;;
    esac
    
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


doc(){
    files="dhadcbx818 dhadprd818 dhadprd281 ntu2013"
    actions="build open"

    if [ -z "$1" ]; then
	echo $files
	read file 
    else
	file=$1
    fi

    if [ -z "$2" ]; then
	echo $actions
	read action 
    else
	action=$2
    fi
    
    path=$HOME/doc/$file
    
    pwd=$PWD
    cd $path
    
    case $action in 
	build) texi2pdf -p -b -c $file.tex
	    ;;
	open) open $file.pdf 
	    ;;
    esac
    cd $pwd 
    
}

_doc(){
    local cur prev files actions
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
 
    files="dhadcbx818 dhadprd818 dhadprd281 ntu2013"

    case "${prev}" in
	dhadcbx818) actions="build open"
	    COMPREPLY=( $(compgen -W "${actions}" -- ${cur}) )
	    return 0 
	    ;;
	dhadprd818) actions="build open"
	    COMPREPLY=( $(compgen -W "${actions}" -- ${cur}) )
	    return 0 
	    ;;
	dhadprd281) actions="build open"
	    COMPREPLY=( $(compgen -W "${actions}" -- ${cur}) )
	    return 0 
	    ;;
	ntu2013) actions="build open"
	    COMPREPLY=( $(compgen -W "${actions}" -- ${cur}) )
	    return 0 
	    ;;
    esac

    COMPREPLY=($(compgen -W "${files}" -- ${cur}))  
}

complete -F _doc doc 


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


setafb() {
    echo -ne "Setting afb ...\r"

    export afb=$HOME/work/cms/afb
    export dat=$afb/dat
    export doc=$afb/doc
    export fig=$afb/doc/fig

    . ~/local/share/root/bin/thisroot.sh 
    #. ~/work/cms/afb/src/sh/bash_completion.sh
    export CVS_RSH=ssh
    export CVSROOT=xshi@cmscvs.cern.ch:/cvs_server/repositories/CMSSW

    export rafb="xshi@lxplus.cern.ch:~/work/cms/afb"
    export wafb="xshi@lxplus.cern.ch:~/www/afb"

    # if [ -z "$1" ]; then
    # 	echo "[1]  v1"
    # 	echo "[2]  v2"
    # 	read menu 
    # else
    # 	menu=$1
    # fi

    # case $menu in 
    # 	1)  code_tag="v1"
    # 	    ;;
    # 	2)  code_tag="v2"
    # 	    ;;
    # esac
    # export rel=$afb/rel/BToKstarMuMu_$code_tag

    export src=$afb/src/BToKstarMuMu
    export plugins=$src/plugins
    export run=$src/python 
    
    alias sel_sync="rsync -av $rafb/dat/sel/ $afb/dat/sel/" 

    echo "Setting afb ... done."
}


setdas() {
    echo -ne "Setting das ...\r"
    setroot 
    export CVS_RSH=ssh
    export CVSROOT=xshi@cmscvs.cern.ch:/cvs_server/repositories/CMSSW
    export das=$HOME/work/cms/das/2012
    echo "Setting das ... done."
}


setdhad() {
    if [ -z "$1" ]; then
	rel=11.4
    else
	rel="$1"
    fi; 
    echo -ne "Setting dhad-$rel ...\r"
    export dhad=$HOME/work/cleo/dhad
    export cbx=$HOME/work/cleo/dhad/doc/cbx818
    export PATH=$dhad/bin:$PATH
    export rel=$rel
    export src=$dhad/src/$rel

    export lns=xs32@lnx235.lns.cornell.edu:/home/xs32
    export CVSROOT=$lns/bak/cvsroot

    export rdhad=$lns/work/CLEO/analysis/DHad/
    if [ ! -e $dhad/bin ] ; then mkdir -p $dhad/bin ; fi    
    if [ ! -e $dhad/src ] ; then mkdir -p $dhad/src ; fi    
    if [ ! -d $src ]; then
	echo "Checking out code ..."
	cd $dhad/src
	cvs co -d $rel dhad/src
    fi 
    ln -sf $dhad/src/$rel/python/dhad.py $dhad/bin/dhad-$rel
    ln -sf $dhad/bin/dhad-$rel $dhad/bin/dhad
    export C3_DATA=$dhad/lib/cleo3/Offline/rel/20080228_FULL/data
    export ROOTSYS=$HOME/local/share/root
    export PATH=$HOME/local/bin:$ROOTSYS/bin:$PATH
    export PYTHONPATH=/Library/Python/2.7:$ROOTSYS/lib:$dhad/lib/python:$dhad/src/$rel/python
    export LD_LIBRARY_PATH=$HOME/local/lib:$ROOTSYS/lib
    echo "Python 2.7.2, ROOT 5.30"

    export dhadprd=$HOME/work/cleo/dhad/doc/dhadprd818
    echo "Setting dhad-$rel ... done."

}


setpxl() {
    echo -ne "Setting pxl ...\r"

    # export pxl=$HOME/work/cms/pxl
    # export src=$pxl/src
    # export psi=$pxl/src/psi46expert
    # export doc=$pxl/doc
    # export fig=$pxl/doc/fig

    pwd=$PWD
    cd ~/work/cms/pxl/cmspxl
    . setup.sh
    cd $pwd

    echo "Setting pxl ... done."
}


setroot() {
    echo -ne "Setting ROOT ...\r"
    . ~/local/share/root/bin/thisroot.sh 
    echo "Setting ROOT ... done."
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

    hostnames=(bohr cern clyd eceg etna fnal kaut lepp rcac)
    
    export bohr=shi210@bohr.physics.purdue.edu
    export cern=xshi@lxplus.cern.ch
    export clyd=shi210@clyde.physics.purdue.edu
    export eceg=shi210@ecegrid.ece.purdue.edu
    export etna=purduepix@etna.physics.purdue.edu
    export fnal=xshi@cmslpc-sl6.fnal.gov
    export kaut=xshi@kautzky.physics.purdue.edu
    export lepp=xs32@lnx235.lepp.cornell.edu
    export rcac=shi210@hep.rcac.purdue.edu


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
	read menu 
    else
	menu=$1
    fi

    case $menu in 
	1) rsync -a -P purduepix@etna.physics.purdue.edu:~/cmspxl/dat/ ~/work/cms/pxl/cmspxl/dat/
	   ;;
	2) rsync -a -P ~/work/cms/pxl/cmspxl/dat/ purduepix@etna.physics.purdue.edu:~/cmspxl/dat/ 
	   ;;
    esac
}


fet() {
    pwd=$PWD
    echo "fetch .org? (y/N)"
    read a
    if [ "$a" = "y" ]; then
	cd ~/.org && hg fetch
    fi 

    echo "fetch .sys? (y/N)"
    read a
    if [ "$a" = "y" ]; then
	cd ~/.sys && hg fetch
    fi 

    echo "fetch .emacs.d? (y/N)"
    read a
    if [ "$a" = "y" ]; then
	cd ~/.emacs.d && hg fetch
    fi 

    cd $pwd 
}


fo() {
    pwd=$PWD
    echo "fetching .org..."
    cd ~/.org && hg fetch
    cd $pwd 
}


po(){
    pwd=$PWD
    echo "pushing .org..."
    cd ~/.org 
    hg ci -m "g" --subrepos
    hg push
    cd $pwd 
}

pus() {
    pwd=$PWD
    echo "push .org? (y/N)"
    read a
    if [ "$a" = "y" ]; then
	cd ~/.org 
	hg ci -m "g" --subrepos
	hg push
    fi 

    echo "push .sys? (y/N)"
    read a
    if [ "$a" = "y" ]; then
	cd ~/.sys 
	hg ci -m "g"
	hg push
    fi 

    echo "push .emacs.d? (y/N)"
    read a
    if [ "$a" = "y" ]; then
	cd ~/.emacs.d 
	hg ci -m "g"
	hg push
    fi 

    cd $pwd 
}


function tabname {
  printf "\e]1;$1\a"
}
 
function winname {
  printf "\e]2;$1\a"
}

