#!/bin/bash

if [[ "$BASH_SOURCE[0]" == "" ]]; then
	export ZOHOME=$(cd $(dirname $0) 2>&1 >/dev/null; pwd)
else
	export ZOHOME=$(cd $(dirname $BASH_SOURCE[0]) 2>&1 >/dev/null; pwd)
fi

export __zo_goenv__=0

zo() {
	_initenv

	if [[ $1 == "" ]]; then
		_jumpdir $ZOHOME
	else
		_jumpdir $ZOHOME/$1
	fi
}

zoproj() {
	if [[ $2 == "" ]]; then
		return
	fi

	_initenv

	dir=$ZOHOME/$2

	if [[ $1 == "create" ]]; then
		mkdir -p $dir
		_jumpdir $dir
	elif [[ $1 == "delete" ]]; then
		rm -rf $dir
		_jumpdir
	fi
}

zogithub() {
	_openBrower https://github.com/envzo
}

zogitlab() {
	if [[ $1 != "" ]]; then
		_openBrower https://git.zuodashi.com/envzo/$1
	fi
}

_openBrower() {
	if [[ $1 != "" ]]; then
		/usr/bin/open -a "/Applications/Google Chrome.app" $1
	fi
}

}

_initenv() {
	# set GOPATH
	# for company uses, it's strongly recommand to have only one GOPATH

	if [[ $__zo_goenv__ == 1 ]]; then
		return
	fi

	export GOPATH=$HOME/envgo
	export GOBIN=$GOPATH/bin
	export PATH=$GOBIN:$PATH

	_welcome

	export __zo_goenv__=1
}

_welcome() {
	echo
	echo "    .-''-.  ,---.   .--.,---.  ,---. ____..--'    ,-----.     ";
	echo "  .'_ _   \ |    \  |  ||   /  |   ||        |  .'  .-,  '.   ";
	echo " / ( \` )   '|  ,  \ |  ||  |   |  .'|   .-'  ' / ,-.|  \ _ \  ";
	echo ". (_ o _)  ||  |\_ \|  ||  | _ |  | |.-'.'   /;  \  '_ /  | : ";
	echo "|  (_,_)___||  _( )_\  ||  _( )_  |    /   _/ |  _\`,/ \ _/  | ";
	echo "'  \   .---.| (_ o _)  |\ (_ o._) /  .'._( )_ : (  '\_/ \   ; ";
	echo " \  \`-'    /|  (_,_)\  | \ (_,_) / .'  (_'o._) \ \`\"/  \  ) /  ";
	echo "  \       / |  |    |  |  \     /  |    (_,_)|  '. \_/\`\`\".'   ";
	echo "   \`'-..-'  '--'    '--'   \`---\`   |_________|    '-----'     ";
	echo
}

_jumpdir() {
	if [ ! -d $1 ]; then
		echo "$1: no such directory"
		return
	fi

	cd $1
}
