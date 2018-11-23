#!/bin/bash

if [[ "$BASH_SOURCE[0]" == "" ]]; then
	export ZOHOME=$(cd $(dirname $0) 2>&1 >/dev/null; pwd)
else
	export ZOHOME=$(cd $(dirname $BASH_SOURCE[0]) 2>&1 >/dev/null; pwd)
fi

export __zo_goenv__=0

zoinitenv() {
	# set GOPATH
	# for company uses, it's strongly recommand to have only one GOPATH

	if [[ $__zo_goenv__ == 1 ]]; then
		return
	fi

	export GOPATH=$ZOHOME
	export GOBIN=$GOPATH/bin
	export PATH=$GOPATH:$PATH

	welcome

	export __zo_goenv__=1
}

zohome() {
	zoinitenv

	if [[ $1 == "/" ]]; then
		jumpdir $ZOHOME
	else
		jumpdir $GOPATH/src/github.com/zodash/$1
	fi
}

welcome() {
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

jumpdir() {
	if [ ! -d $1 ]; then
		return
	fi

	if [[ $1 == "/" ]]; then
		cd $ZOHOME
	else
		cd $1
	fi
}

zoproj() {
	if [[ $2 == "" ]]; then
		return
	fi

	zoinitenv

	dir=$GOPATH/src/github.com/zodash/$2

	if [[ $1 == "create" ]]; then
		mkdir -p $dir
		jumpdir $dir
	elif [[ $1 == "delete" ]]; then
		rm -rf $dir
		jumpdir /
	fi
}

zogithub() {
	homepage=https://github.com/envzo
	/usr/bin/open -a "/Applications/Google Chrome.app" $homepage
}
