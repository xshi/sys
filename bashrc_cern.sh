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
alias bs="bjobs"
alias bsr="bjobs -u $USER | grep RUN | wc" 
alias en="emacs -nw"
alias ec="emacsclient"
alias ls="ls -h --color"
alias lsd="ls -d */"
alias l="ls"
alias ll="ls -lh"
alias p="pwd"
alias cl="rm *~; rm *.orig"
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
export ILCSOFT=/afs/cern.ch/work/x/xshi/public/ILCSOFT 
unset SSH_ASKPASS  
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


lk_hist() {
    for i in `seq 1 9`; do
        ln -sf ~/.bash_history ~/.history.lxplus00$i.cern.ch;
    done
    for i in `seq 10 99`; do
        ln -sf ~/.bash_history ~/.history.lxplus0$i.cern.ch;
    done
    for i in `seq 100 999`; do
        ln -sf ~/.bash_history ~/.history.lxplus$i.cern.ch;
    done
}


mnt() {
    if [ -z "$1" ]; then
	echo "[e] eosmount /afs/cern.ch/user/x/xshi/eos"
	echo "[ef] eosforceumount /afs/cern.ch/user/x/xshi/eos"
	echo "[eu] eosumount /afs/cern.ch/user/x/xshi/eos"
	read menu 
    else
	menu=$1
    fi
    
    case $menu in 
	e)  eosmount /afs/cern.ch/user/x/xshi/eos
	    ;;
	ef) eosforceumount /afs/cern.ch/user/x/xshi/eos 
	    eosmount /afs/cern.ch/user/x/xshi/eos
	    ;;
	eu)  eosumount /afs/cern.ch/user/x/xshi/eos
	    ;;
    esac
}


setafb() {
    echo -ne "Setting afb ...\r"
    export afb=$HOME/work/cms/afb
    export src=$afb/src
    export dat=$afb/dat
    export doc=$afb/doc
    export fig=$doc/fig
    export log=$afb/log
    export rafb=$afb

   if [ -z "$1" ]; then
	echo "[run2011v0]   CMSSW_4_2_8_patch7, run2011v0"
	echo "[run2011v1]   CMSSW_4_2_8_patch7, run2011v1"
	echo "[run2012v0]   CMSSW_5_3_9_patch3, run2012v0"
	read code_tag
    else
	code_tag=$1
    fi

    case $code_tag in 
	run2011v0)  cmssw="CMSSW_4_2_8_patch7"
	    ;;
	run2011v1)  cmssw="CMSSW_4_2_8_patch7"
	    ;;
	run2012v0)  cmssw="CMSSW_5_3_9_patch3"
	    ;;
    esac

    export rel=$afb/rel/$cmssw/src
    cd $rel ; eval `scram runtime -sh` 
    export build=$rel/BphAna/BToKstarMuMu_$code_tag
    export run=$build/python 

    case $2 in 
	g) setgrid
	    ;;
    esac

    #. $src/sh/bash_completion.sh
    echo "Setting afb ... done."
}

setdas() {
    echo -ne "Setting das ...\r"
    export das=$HOME/work/cms/das/2012
    export src=$das/CMSSW_5_2_5/src
    echo "Setting das ... done."
}


setgrid() {
    echo -ne "Setting GRID ...\r"
    source /afs/cern.ch/cms/LCG/LCG-2/UI/cms_ui_env.sh
    source /afs/cern.ch/cms/ccs/wm/scripts/Crab/crab.sh 
    #voms-proxy-init --voms cms
    echo "Setting GRID ... done."
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


setmcb() {
    if [ -z "$1" ]; then
	echo "[0] CMSSW_5_3_7"
	echo "[1] CMSSW_4_4_4"
	echo "[2] CMSSW_4_2_8_patch7"
	echo "[3] CMSSW_4_1_8_patch9"
	read menu 
    else
	menu=$1
    fi
    
    case $menu in 
	0)  cmssw="CMSSW_5_3_7"
	    ;;
	1)  cmssw="CMSSW_4_4_4"
	    ;;
	2)  cmssw="CMSSW_4_2_8_patch7"
	    ;;
	3) cmssw="CMSSW_4_1_8_patch9"
	    ;; 
    esac

    echo -ne "Setting mcb ...\r"
    export mcb=$HOME/work/cms/mcb
    export rel=$mcb/rel/$cmssw/src
    cd $rel ; eval `scram runtime -sh`
    echo "Setting mcb ... done."
}



setpxl() {
    export pxl=$HOME/work/cms/pxl

    if [ -z "$1" ]; then
	echo "[tbm] TestBeam EUTel Software"
	echo "[cal] cmspxltb Calibration Software"
	read menu 
    else
	menu=$1
    fi

    case $menu in 
	
	tbm) 
	    settbm $2
	    ;;
	cal)
	    export src=$HOME/work/cms/pxl/tbm/cmspxltb
	    cd $src
	    . env.sh 
	    ;;
    esac
}


setroot() {
    echo -ne "Setting ROOT ...\r"
    if [ -z "$1" ]; then
	root=5.32.01
	. /afs/cern.ch/sw/lcg/external/gcc/4.3.2/x86_64-slc5/setup.sh
	. /afs/cern.ch/sw/lcg/app/releases/ROOT/5.32.01/x86_64-slc5-gcc43-opt/root/bin/thisroot.sh
    fi; 

    echo "Setting ROOT ... $root done."
}

settbm() {
    echo -ne "Setting tbm ...\r"
    export WORKSPACE=`pwd`

    if [ -z "$1" ]; then
	export TB_ANALYSIS=/afs/cern.ch/user/x/xshi/work/cms/pxl/tbm/TestBeam/Analysis
	export ILCSOFT=${TB_ANALYSIS}/ilcsoft 
	cd $ILCSOFT/v01-12/Eutelescope/HEAD/ 
	source build_env.sh 
    else
	source /afs/cern.ch/work/y/ymtzeng/public/PixelBeamTestAnalysis/env_current.sh
    fi;

    export pxl=$HOME/work/cms/pxl
    export tbm=$pxl/tbm
    #export simplesub=$pxl/tbm/simplesub
    export simplesub=${EUTELESCOPE}/simplesub

    export dqm=$simplesub/dqm  #_dev use the hg instead 
    export dat=$simplesub/CMSPixel 
    
    cd $dqm && source setup.sh
    export LD_LIBRARY_PATH=/opt/cactus/lib:$LD_LIBRARY_PATH
    export PATH=/opt/cactus/bin:$PATH
    export PYTHONPATH=$HOME/work/cms/pxl/tbm/uhal/PyChips_1_4_3/src:$PYTHONPATH
    cd ${WORKSPACE} 
    echo "Setting tbm ... done."
}

setdqm() {
    echo -ne "Setting dqm ...\r"
    . /afs/cern.ch/cms/Tracker/Pixel/HRbeamtest/dqm/v3/setup.sh 
    export dqm=/afs/cern.ch/cms/Tracker/Pixel/HRbeamtest/dqm
    echo "Setting dqm ... done."
}


sl() {
    if [ -z "$1" ]; then
	echo "[f5]  cmslpc-sl5.fnal.gov"
	echo "[n]   ntucms1.cern.ch"
	echo "[np]  pixel_dev@ntucms1"
	echo "[t]   pcpixeltb"
	echo "[db]  mysql --host=dbod-cmspxltb.cern.ch --port=5503 --user=admin -p"
	read menu 
    else
	menu=$1
    fi

    case $menu in 
	f5) ssh -Y xshi@cmslpc-sl5.fnal.gov
	    ;;
	n) ssh -Y xshi@ntucms1.cern.ch
	    ;;
	np) ssh -Y pixel_dev@ntucms1.cern.ch
	    ;;
 	p) ssh pixel_dev@pccmspixels.cern.ch
	    ;;
	t) ssh -Y xshi@pcpixeltb.cern.ch
	    ;; 
	db) mysql --host=dbod-cmspxltb.cern.ch --port=5503 --user=admin -p
	    ;; 
    esac
}




uptbm(){
    echo "Updating tbm ..."
    cd ${EUTELESCOPE}/../branches/cmspixel
    svn update
    cd ${EUTELESCOPE}/../
    cp branches/cmspixel/src/*cc HEAD/src/
    cp branches/cmspixel/include/*h HEAD/include/
    
    cd ${EUTELESCOPE}/build
    cmake ..
    make clean
    make install -j 4
    
    cd ${EUTELESCOPE}
    pwd
}


pkgdqm(){
    if [ -z "$1" ]; then
	echo "Please give the tag number. (eg: 1.2)"
    else
	echo "Packging dqm $1 ... "
	cd $dqm 
	hg tag -f "$1"
	hg arc -r "$1" ~/www/pxl/dqm/src/dqm-$1.tar.gz
	echo "Saved as: https://cern.ch/xshi/pxl/dqm/src/dqm-$1.tar.gz" 
    fi;
}


if [ `hostname -s` = ntucms1 ] || [ `hostname -s` = ntucms2 ]  ; then
    setroot
fi


