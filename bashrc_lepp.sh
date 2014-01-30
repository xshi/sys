#!/bin/sh


#--------------------------------------------------
# General Aliases
#--------------------------------------------------
alias ls="ls -h --color"
alias lsd="ls -d */"
alias l="ls"
alias ll="ls -lh"
alias en="emacs -nw"
alias ec="emacsclient"
alias rm~="rm *~"
alias qs="qstat -u $USER"
alias qsr="qstat -u $USER | grep ' r ' | wc" 
alias qsw="qstat -u $USER | grep qw | wc" 
alias k1="kill %1"
alias prt="lpr -P n223_brn_5370 -o InputSlot=AutoSelect -o PageSize=Letter -o Duplex=DuplexNoTumble"

alias evo='/usr/java/default/bin/javaws ~/local/lib/koala.jnlp'
alias jgnash='java -jar ~/local/share/jGnash/jgnash2.jar'

#--------------------------------------------------
# General ENV
#--------------------------------------------------

export TEXMFCNF=$HOME/local/share/texmf/web2c
export PATH=$HOME/local/bin:$HOME/local/sbin:$PATH
export CVSROOT=$HOME/bak/cvsroot
export CVSEDITOR=vim
export PRINTER=N223_BRN_5370

export KRB5CCNAME_LEPP=~/local/.private/krb5_lepp
export KRB5CCNAME_FNAL=~/local/.private/krb5_fnal
export KRB5CCNAME_CERN=~/local/.private/krb5_cern


 
#--------------------------------------------------
# Functions 
#--------------------------------------------------



ki() {
    if [ -z "$1" ]; then
	echo "lepp (l) , fnal (f), cern (c) ?"
    fi;
    
    if [ "$1" = "l" ]; then
	kinit -A -f -c $KRB5CCNAME_LEPP xs32@LNS.CORNELL.EDU
	KRB5CCNAME=$KRB5CCNAME_LEPP
    fi; 

    if [ "$1" = "f" ]; then
	kinit -A -f -c $KRB5CCNAME_FNAL xshi@FNAL.GOV
	KRB5CCNAME=$KRB5CCNAME_FNAL
    fi; 

    if [ "$1" = "c" ]; then
	kinit -A -f -c $KRB5CCNAME_CERN xshi@CERN.CH
	KRB5CCNAME=$KRB5CCNAME_CERN
    fi; 

}


sl() {

    if [ -z "$1" ]; then
	echo "lepp (l[c,1]), fnal (f), cern (c[5])?"

    elif [ "$1" = "l" ]; then
	export KRB5CCNAME=FILE:$KRB5CCNAME_LEPP
	ssh -X xs32@lnx235.lns.cornell.edu

    elif [ "$1" = "l5" ]; then
	export KRB5CCNAME=FILE:$KRB5CCNAME_LEPP
	ssh -X xs32@lnx6212.lns.cornell.edu

    elif [ "$1" = "lc" ]; then
	export KRB5CCNAME=FILE:$KRB5CCNAME_LEPP
	ssh -X xs32@lnx134.lns.cornell.edu

    elif [ "$1" = "l1" ]; then
	export KRB5CCNAME=FILE:$KRB5CCNAME_LEPP
	ssh -X xs32@lnx7228.lns.cornell.edu

    elif [ "$1" = "l5" ]; then
	export KRB5CCNAME=FILE:$KRB5CCNAME_LEPP
	ssh -X xs32@lnx6212.lns.cornell.edu

    elif [ "$1" = "f" ]; then
	export KRB5CCNAME=FILE:$KRB5CCNAME_FNAL
	ssh -X xshi@cmslpc-sl5.fnal.gov

    elif [ "$1" = "c" ]; then
	export KRB5CCNAME=FILE:$KRB5CCNAME_CERN
	ssh -X xshi@lxplus.cern.ch

    elif [ "$1" = "c5" ]; then
	export KRB5CCNAME=FILE:$KRB5CCNAME_CERN
	ssh -X xshi@lxplus5.cern.ch

    fi; 
    
}

ks() {
    if [ -z "$1" ]; then
	echo "lepp (l) , fnal (f)?"
    fi;
    
    if [ "$1" = "l" ]; then
	export KRB5CCNAME=FILE:$KRB5CCNAME_LEPP
    fi; 

    if [ "$1" = "f" ]; then
	export KRB5CCNAME=FILE:$KRB5CCNAME_FNAL
    fi; 

}


setdhad() {
    if [ -z "$1" ]; then
	rel=11.4
    else
	rel="$1"
    fi; 

    echo "Setting dhad-$rel ..."
    directory="$HOME/work/CLEO/analysis/DHad/src/$rel"

    if [ ! -d $directory ]; then
	echo "Checking out code ..."
	cvs co -d $HOME/work/CLEO/analysis/DHad/src/$rel dhad/src
    fi 
    
    . ~/work/CLEO/analysis/DHad/src/$rel/bash/setup.sh;
    export rdhad=$dhad
}


setcms() {

    . /nfs/cms/sw/install/cmsset_default.sh

    
    if [ -z "$1" ]; then
	rel=2.0
    else
	rel="$1"
    fi; 
    . ~/work/cms/src/$rel/setup;

    if [ -z "$2" ]; then
	cmsswf=$CMSSW
    else
	cmsswf="$2"
    fi;
    
    
    export fnal=xshi@cmslpc.fnal.gov
    export cmsf=$fnal:/uscms/home/xshi/work/cms
    export cmssrcf=$cmsf/src/$cmsswf/src
    export susyf=$cmssrcf/SusyAnalysis
    export susytestf=$susyf/SusyAnalyzer/test
}

setpyroot() {
    if [ -z "$1" ]; then
	echo "cleo (c), hacked (h), local(l) ?"

    elif [ "$1" = "c" ]; then
	export C3PYTHONPATH=$C3_OTHER/python
	export PATH=$C3PYTHONPATH/bin:$ROOTSYS/bin:$PATH
	export PYTHONPATH=$C3PYTHONPATH:$ROOTSYS/lib:$dhad/lib/python:$dhad/src/$rel/python
	export LD_LIBRARY_PATH=$C3PYTHONPATH/lib:$ROOTSYS/lib
	echo "Python 2.4 ROOT 4.03"

    elif [ "$1" = "h" ]; then
	#export ROOTSYS=/nfs/cor/user/ponyisi/root5/
	#export ROOTSYS=/nfs/cor/user/ponyisi/root5-old/
	export ROOTSYS=$HOME/local/share/root/5.10
	export C3PYTHONPATH=$C3_OTHER/python
	export PATH=$C3PYTHONPATH/bin:$ROOTSYS/bin:$PATH
	export PYTHONPATH=$C3PYTHONPATH:$ROOTSYS/lib:$dhad/lib/python:$dhad/src/$rel/python
	export LD_LIBRARY_PATH=$C3PYTHONPATH/lib:$ROOTSYS/lib
	echo "Python 2.4 ROOT 5.10 (hacked)"

    elif [ "$1" = "l" ]; then
	export ROOTSYS=$HOME/local/share/root/5.28
	export PATH=$HOME/local/bin:$ROOTSYS/bin:$PATH
	export PYTHONPATH=$HOME/local/lib/python2.7:$ROOTSYS/lib:$dhad/lib/python:$dhad/src/$rel/python
	export LD_LIBRARY_PATH=$HOME/local/lib:$ROOTSYS/lib
	echo "Python 2.7.1 ROOT 5.28"

    fi;
}


pl() {
    if [ -z "$1" ]; then
	echo "french info(i), culture(c), inter (t) ?"
    elif [ "$1" = "i" ]; then
	xmms ~/.pri/france_info_64.m3u
    elif [ "$1" = "c" ]; then
	xmms ~/file/audio/french/france-culture-radio.m3u
    elif [ "$1" = "t" ]; then
	xmms ~/file/audio/french/france_inter_mp3-128k.m3u
    else
	echo "Unknown arg: " $1
    fi; 

}
